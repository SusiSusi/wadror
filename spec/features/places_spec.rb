require 'rails_helper'

describe "Places" do

  it "if API returns one place, it is shown on the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
                                                                    [ Place.new(name:"Oljenkorsi", id:1) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if API returns many places, they all are shown on the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
        [ Place.new(name:"Oljenkorsi", id:1),
          Place.new(name:"Kumpulan keitot", id:2),
          Place.new(name:"Oluthuone", id:3)]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Kumpulan keitot"
    expect(page).to have_content "Oluthuone"
  end

  it "if API returns an empty hash, notice is shown on the page" do
    city = "Lieto"
    allow(BeermappingApi).to receive(:places_in).with(city).and_return( [] )

    visit places_path
    fill_in('city', with: city)
    click_button "Search"

    expect(page).to have_content "No locations in #{city}"
  end

end