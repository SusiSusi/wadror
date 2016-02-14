require 'rails_helper'

include Helpers

RSpec.describe User, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  it "has the username set correctly" do
    user = User.new username:"Pekka"

    expect(user.username).to eq("Pekka")
  end

 describe "is not saved" do
    let(:user) { User.create username:"Pekka" }

    it "without a password" do
      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end

    it "with a password too short" do
      user.password = "moi"
      user.password_confirmation = "moi"

      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end

    it "if the password does not have a numbers" do
      user.password = "Moikka"
      user.password_confirmation = "Moikka"

      expect(user).not_to be_valid
      expect(User.count).to eq(0)
    end

  end

  describe "with a proper password" do
    let(:user) { FactoryGirl.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      rating = FactoryGirl.create(:rating)
      rating2 = FactoryGirl.create(:rating2)

      user.ratings << rating
      user.ratings << rating2

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe "favorite beer" do
    let(:user) { FactoryGirl.create(:user) }

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_beer)
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = create_beer_with_rating(user, 10)

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_ratings(user, 10, 20, 15, 7, 9)
      best = create_beer_with_rating(user, 25)

      expect(user.favorite_beer).to eq(best)
    end
  end

  #describe "favorite style" do
   # let(:user) { FactoryGirl.create(:user) }

    #it "has method for determining one" do
     # expect(user).to respond_to(:favorite_style)
    #end

    #it "without ratings does not have one" do
    #  expect(user.favorite_style).to eq(nil)
    #end

    #it "is the only style if only one rating" do
     # beer = create_beer_with_rating(user, 20)

      #expect(user.favorite_style).to eq(beer.style)
    #end

#    it "is the one with highest rating if several rated" do

 #   end
  #end

end