module RatingAverage

  def average_rating
    return self.ratings.average(:score).to_f
  end

end
