class PosturesController < ApplicationController
  before_action :set_posture, only: [:show, :edit, :update, :destroy]
  before_action :set_practice, only: [:index, :new, :create]

  def index
    @postures = @practice.postures
  end

  def show
  end

  def new
    @posture = @practice.postures.build
  end

  def create
    if user_signed_in?
      if @practice.category != 'personal'
        # Dupliquer la pratique suggérée et l'assigner à l'utilisateur
        @practice = @practice.dup
        @practice.user = current_user
        @practice.category = 'personal'
        @practice.save
      end

      # Ajouter la posture à la pratique (qu'elle soit dupliquée ou non)
      @posture = @practice.postures.build(posture_params)

      if @posture.save
        redirect_to practice_postures_path(@practice), notice: "Posture ajoutée avec succès."
      else
        render :new, status: :unprocessable_entity
      end

    else
      # Stocker la pratique modifiée en session
      session[:temporary_practices] ||= []

      # Vérifier si une copie existe déjà en temporaire
      existing_practice = session[:temporary_practices].find { |p| p["id"] == @practice.id }

      if existing_practice
        # Ajouter la posture à la copie existante
        existing_practice["postures"] ||= []
        existing_practice["postures"] << posture_params
      else
        # Créer une nouvelle copie avec la posture ajoutée
        new_practice = @practice.attributes.except("id", "created_at", "updated_at")
        new_practice["postures"] = [posture_params]
        session[:temporary_practices] << new_practice
      end

      redirect_to new_user_session_path, notice: "Connecte-toi pour enregistrer ta séance modifiée."
    end
  end

  def edit
  end

  def update
    if @posture.update(posture_params)
      redirect_to practice_postures_path(@posture.practice), notice: "Posture mise à jour."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @posture.destroy
    redirect_to practice_postures_path(@posture.practice), notice: "Posture supprimée."
  end

  private

  def set_posture
    @posture = Posture.find(params[:id])
    @practice = @posture.practice  # On récupère la practice associée
  end

  def set_practice
    @practice = Practice.find(params[:practice_id])
  end

  def posture_params
    params.require(:posture).permit(:name, :time, :holding_breath_time, :holding_breath_ending)
  end
end
