require 'rails_helper'

RSpec.describe Beer, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  it "has the name and style set correctly" do
    beer = Beer.new name:"Olut", style:"Lager"

    expect(beer).to be_valid
    expect(beer.name).to eq("Olut")
    expect(beer.style).to eq("Lager")
  end

  it "is not saved without a name" do
    beer = Beer.new style:"Lager"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not saved without a style" do
    beer = Beer.new name:"Olut"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end
end
