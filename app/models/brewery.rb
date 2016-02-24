class Brewery < ActiveRecord::Base
  include RatingAverage

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, presence: true
  validates :year, numericality: { less_than_or_equal_to: Proc.new { Time.now.year } }

  scope :active, -> { where active:true }
  scope :retired, -> { where active:[nil,false] }

  def to_s
    return "#{self.name}, #{brewery.name}"
  end

  def self.top(n)
    sorted_by_rating_in_desc_order = Brewery.all.sort_by{ |b| -(b.average_rating||0 )}
    return sorted_by_rating_in_desc_order.take(n)
  end

end
