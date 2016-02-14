class User < ActiveRecord::Base
  include RatingAverage

  has_secure_password

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, -> { distinct }, through: :memberships

  validates :username, uniqueness: true,
            length: { minimum: 3, maximum: 15 }
  validates :password, format: { :with => /\A(?=.*[A-Z])(?=.*[0-9]).{4,}\z/,
                                 message: "must be at least 4 characters including one uppercase letter and one number" }


  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

#  def favorite_style
 #   return nil if ratings.empty?
  #  ratings.order(score: :desc).limit(1).first.beer.style
  #end

end
