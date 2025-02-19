class PracticesController < ApplicationController
  before_action :set_practice, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]  # L'authentification est nécessaire pour créer, modifier, ou supprimer

  def index
    @practices = Practice.all
  end

  def show
  end

  def new
    @practice = Practice.new
  end

  def create
    if user_signed_in?
      # Utilisateur connecté → enregistrement en base avec catégorie "personal"
      @practice = current_user.practices.build(practice_params)
      @practice.category = "personal"

      if @practice.save
        redirect_to practices_path, notice: "Votre pratique a été créée avec succès."
      else
        render :new, status: :unprocessable_entity
      end
    else
      # Utilisateur non connecté → stockage en session
      session[:temporary_practices] ||= []
      session[:temporary_practices] << practice_params.to_h

      redirect_to practices_path, notice: "Votre pratique a été ajoutée temporairement. Connectez-vous pour l'enregistrer définitivement."
    end
  end


  def edit
    @practice = Practice.find(params[:id])

    # Si c'est une pratique suggérée, créer une copie pour l'utilisateur connecté
    if @practice.category != 'personal' && user_signed_in?
      @practice = @practice.dup  # Créer une copie de la pratique suggérée
      @practice.user = current_user # Assigner cette pratique à l'utilisateur connecté
      @practice.category = 'personal' # La pratique devient personnelle

      # Sauvegarde de la pratique en session si on veut aussi la garder temporairement
      session[:temporary_practices] ||= []
      session[:temporary_practices] << @practice.attributes
    end
  end


  def update
    if @practice.update(practice_params)
      redirect_to @practice, notice: "Votre séance a été mise à jour."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @practice.destroy
    redirect_to practices_path, notice: "Séance supprimée avec succès."
  end

  private

  def set_practice
    @practice = Practice.find(params[:id])
  end

  def practice_params
    params.require(:practice).permit(:name)
  end
end
