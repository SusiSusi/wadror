module RatingAverage

  def average_rating
    return self.ratings.average(:score)
  end

end
