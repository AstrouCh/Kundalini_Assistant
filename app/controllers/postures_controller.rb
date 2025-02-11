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
    @posture = @practice.postures.build(posture_params)

    if @posture.save
      redirect_to practice_postures_path(@practice), notice: "Posture ajoutée avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @posture.update(posture_params)
      redirect_to @posture, notice: "Posture mise à jour."
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
  end

  def set_practice
    @practice = Practice.find(params[:practice_id])
  end

  def posture_params
    params.require(:posture).permit(:name, :time, :holding_breath_time, :holding_breath_ending)
  end
end
