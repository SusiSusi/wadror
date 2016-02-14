require 'rails_helper'

describe "Breweries pages" do

  it "should not have any before been created" do
    visit breweries_path
    expect(page).to have_content 'Listing Breweries'
    expect(page).to have_content 'Number of breweries: 0'

    #save_and_open_page
  end

  describe "when breweries exists" do
    before :each do
      @breweries = ["Koff", "Karjala", "Schlenkerla"]
      year = 1896

      @breweries.each do |brewery_name|
        FactoryGirl.create(:brewery, name: brewery_name, year: year += 1)
      end
      visit breweries_path
    end

    it "lists breweries and total number of breweries" do
      expect(page).to have_content "Number of breweries: #{@breweries.count}"

      @breweries.each do |brewery_name|
        expect(page).to have_content brewery_name
      end
      #save_and_open_page
    end

    it "allows user to navigate to page of Brewery" do
      click_link "Koff"

      expect(page).to have_content "Koff"
      expect(page).to have_content "Established at 1897"

      #save_and_open_page
    end
  end
end