require 'rails_helper'

include Helpers

describe "Rating" do

  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }
  let!(:user2) { FactoryGirl.create :user, username:"Miisa", password:"Miisa12", password_confirmation:"Miisa12" }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:15)

    expect{
      click_button('Create Rating')
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  it "page lists ratings and total number of ratings" do
    brewery = FactoryGirl.create(:brewery)
    @beers = create_beers_with_ratings(user, "lager", brewery, 10, 20, 15, 7, 9)

    visit ratings_path

    expect(page).to have_content "Number of ratings: 5"

    @beers.each do |beer_name|
      expect(page).to have_content beer_name
    end
    #save_and_open_page
  end

  describe "by user" do

    before :each do
      brewery = FactoryGirl.create(:brewery)
      @rated_beers = create_beers_with_ratings(user, "lager", brewery, 10, 20, 15, 7, 9)
      create_beers_with_ratings(user2, "Stout", brewery, 22, 13, 9)
      visit user_path(user)
    end

    it "displays correctly in user's page" do
      expect(page).to have_content "Has made 5 ratings, average 12.2"
      expect(Rating.count).to eq(8)
      expect(user.ratings.count).to eq(5)

      @rated_beers.each do |beer_name|
        expect(page).to have_content beer_name
      end
      #save_and_open_page
    end

    it "is deleted correctly" do
      page.find('li', :text => @rated_beers[1]).click_link('Delete')

      expect(page).to have_content "Has made 4 ratings, average 10.25"
      expect(Rating.count).to eq(7)
      expect(user.ratings.count).to eq(4)

      #save_and_open_page
    end
  end

end