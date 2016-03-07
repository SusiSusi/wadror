class RatingsController < ApplicationController

  def index
    @ratings = Rating.all
#    @recent_ratings = Rating.recent
#    @top_breweries = Brewery.top 3
#    @top_beers = Beer.top 3
#    @top_users = User.top 3
#    @top_styles = Style.top 3
    Rails.cache.write("beer top 3", Beer.top(3)) if cache_does_not_contain_data_or_it_is_too_old "beer top 3"
    @top_beers = Rails.cache.read "beer top 3"
    Rails.cache.write("brewery top 3", Brewery.top(3)) if cache_does_not_contain_data_or_it_is_too_old "brewery top 3"
    @top_breweries = Rails.cache.read "brewery top 3"
    Rails.cache.write("style top 3", Style.top(3)) if cache_does_not_contain_data_or_it_is_too_old "style top 3"
    @top_styles = Rails.cache.read "style top 3"
    Rails.cache.write("user top 3", User.top(3)) if cache_does_not_contain_data_or_it_is_too_old "user top 3"
    @top_users = Rails.cache.read "user top 3"
    Rails.cache.write("recent ratings", Rating.recent) if cache_does_not_contain_data_or_it_is_too_old "recent ratings"
    @recent_ratings = Rails.cache.read "recent ratings"
    #byebug
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.create params.require(:rating).permit(:score, :beer_id)

    if current_user.nil?
      redirect_to signin_path, notice: 'You should be signed in'
    elsif @rating.save
      current_user.ratings << @rating
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to :back
  end

  def cache_does_not_contain_data_or_it_is_too_old key
    if Rails.cache.read(key) == nil
      return true
    else
      return false
    end
  end

end