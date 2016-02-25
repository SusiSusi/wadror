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


  def self.top(n)
    sorted_by_rating_in_desc_order = User.all.sort_by{ |b| -(b.ratings.count||0 )}
    return sorted_by_rating_in_desc_order.take(n)
  end

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    favorite :style
  end

  def favorite_brewery
    favorite :brewery
  end

  # def method_missing(method_name, *args, &block)
  #  if method_name =~ /^favorite_/
  #   category = method_name[9..-1].to_sym
  #  self.favorite category
  #else
  # return super
  #end
  #end

  def favorite(category)
    return nil if ratings.empty?

    rated = ratings.map{ |r| r.beer.send(category) }.uniq
    rated.sort_by { |item| -rating_of(category, item) }.first
  end

  private

  def rating_of(category, item)
    ratings_of = ratings.select{ |r| r.beer.send(category)==item }
    ratings_of.map(&:score).inject(&:+) / ratings_of.count.to_f
  end

end
