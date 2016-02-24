class Style < ActiveRecord::Base
  has_many :beers

  def to_s
    return "#{self.name}"
  end

  def self.top(n)
    sorted_by_rating_in_desc_order = Beer.all.sort_by{ |b| -(b.average_rating||0 )}
    return sorted_by_rating_in_desc_order.take(n)
  end

end
