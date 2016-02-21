class PlacesController < ApplicationController
#  before_action :set_place, only: [:show, :edit, :update, :destroy]

  def index
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    session[:city] = params[:city]
    if (@places.empty?)
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
    end
  end

  def show
    @place = BeermappingApi.fetch_places_in(session[:city]).find{ |place| place.id == params[:id]}
  end


  #def set_place
   # @place = BeermappingApi.fetch_place_in(params[:id])
    #if (@place.nil?)
     # redirect_to places_path
    #end
  #end

end