require 'rails_helper'

include Helpers

describe "Beer" do

  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }

  #before :each do
  #  sign_in(username:"Pekka", password:"Foobar1")
  #end

  it "with valid name, is added to the database" do
    visit new_beer_path

    fill_in('beer[name]', with:'Olppi')
    select('Lager', from:'beer[style]')
    select('Koff', from:'beer[brewery_id]')

    expect{
      click_button('Create Beer')
    }.to change{Beer.count}.from(0).to(1)

    expect(page).to have_content "Beer was successfully created."
    #save_and_open_page
  end

  it "with invalid name, is not added to the database" do
    visit new_beer_path

    fill_in('beer[name]', with:'')
    select('Lager', from:'beer[style]')
    select('Koff', from:'beer[brewery_id]')
    click_button('Create Beer')

    expect(Beer.count).to eq(0)
    expect(page).to have_content "Name can't be blank"

    #save_and_open_page
  end
end