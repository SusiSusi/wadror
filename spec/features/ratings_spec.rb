require 'rails_helper'

include Helpers

describe "Rating" do

  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:brewery2) { FactoryGirl.create :brewery, name:"Hartwall" }
  let!(:style) { FactoryGirl.create :style, name:"Lager" }
  let!(:style2) { FactoryGirl.create :style, name:"Stout", description:"tilili" }
  let!(:style3) { FactoryGirl.create :style, name:"White", description:"tilili" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }
  let!(:user2) { FactoryGirl.create :user, username:"Miisa", password:"Miisa12", password_confirmation:"Miisa12" }
  let!(:user3) { FactoryGirl.create :user, username:"Muru", password:"Miisa12", password_confirmation:"Miisa12" }

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

  describe "page lists ratings statics: " do

    before :each do
      @beers_user = create_beers_with_ratings(user, style, brewery2, 10, 20, 15, 7, 9)
      @beers_user2 = create_beers_with_ratings(user2, style3, brewery, 13, 22, 5, 17, 19)
      @beers_user3 = create_beers_with_ratings(user3, style2, brewery2, 1, 23, 12, 7, 4)
      visit ratings_path
    end

    it "best beers corretly" do
      expect(page).to have_content "Best beers"
      expect(page).to have_content "anonymous	23.0"
      expect(page).to have_content "anonymous	22.0"
      expect(page).to have_content "anonymous	20.0"
    end

    it "best breweries correctly" do
      expect(page).to have_content "Best breweries"
      expect(page).to have_content "Koff 15.2"
      expect(page).to have_content "Hartwall 10.8"
    end

    it "best styles correctly" do
      expect(page).to have_content "Best styles"
      expect(page).to have_content "White	15.2"
      expect(page).to have_content "Lager	12.2"
      expect(page).to have_content "Stout	9.4"
    end

    it "Most active users correctly" do
      expect(page).to have_content "Recent ratings"
      expect(page).to have_content "Pekka	anonymous, Hartwall	Lager	Hartwall 5"
      expect(page).to have_content "Miisa	anonymous, Koff	White	Koff 5"
      expect(page).to have_content "Muru	anonymous, Hartwall	Stout	Hartwall 5"
    end

    it "recent ratings correctly" do
      expect(page).to have_content "Recent ratings"
      expect(page).to have_content "anonymous, Hartwall	4	Muru"
      expect(page).to have_content "anonymous, Hartwall	7	Muru"
      expect(page).to have_content "anonymous, Hartwall	12	Muru"
      expect(page).to have_content "anonymous, Hartwall	23	Muru"
      expect(page).to have_content "anonymous, Hartwall	1	Muru"
    end
  end

  describe "by user" do

    before :each do
      @rated_beers = create_beers_with_ratings(user, style, brewery, 10, 20, 15, 7, 9)
      create_beers_with_ratings(user2, style2, brewery, 22, 13, 9)
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
      page.find('tr', :text => @rated_beers[1]).click_link('Delete')

      expect(page).to have_content "Has made 4 ratings, average 10.3"
      expect(Rating.count).to eq(7)
      expect(user.ratings.count).to eq(4)
    end
  end
end