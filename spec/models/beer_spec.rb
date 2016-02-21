require 'rails_helper'

RSpec.describe Beer, type: :model do

  let(:style) { Style.create name:"Lager", description:"titi" }

  it "has the name and style set correctly" do
    beer = Beer.new name:"Olut", style_id:style.id

    expect(beer).to be_valid
    expect(beer.name).to eq("Olut")
    expect(beer.style.name).to eq("Lager")
  end

  it "is not saved without a name" do
    beer = Beer.new

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not saved without a style" do
    beer = Beer.new name:"Olut"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end
end
