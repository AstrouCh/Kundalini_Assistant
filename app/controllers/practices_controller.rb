class PracticesController < ApplicationController
  before_action :set_practice, only: [:show, :edit, :update, :destroy]

  def index
    @practices = Practice.all
  end

  def show
  end

  def new
    @practice = Practice.new
  end

  def create
    @practice = Practice.new(practice_params)
    @practice.user = current_user  # Si un utilisateur est connecté

    if @practice.save
      redirect_to @practice, notice: "Votre séance a été créée avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
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
