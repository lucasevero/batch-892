class PlantsController < ApplicationController
  before_action :set_plant, only: [:destroy]
  def create
    # raise
    @plant = Plant.new(plant_params)
    @garden = Garden.find(params[:garden_id])
    @plant.garden = @garden

    if @plant.save
      redirect_to garden_path(@garden)
    else
      @plants = @garden.plants
      render "gardens/show"
    end
  end

  def destroy
    @garden = @plant.garden
    @plant.destroy
    redirect_to garden_path(@garden)
  end

  private

  def plant_params
    params.require(:plant).permit([:name, :image_url])
  end

  def set_plant
    @plant = Plant.find(params[:id])
  end
end
