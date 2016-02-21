# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
b1 = Brewery.create name:"Koff", year:1897
b2 = Brewery.create name:"Malmgard", year:2001
b3 = Brewery.create name:"Weihenstephaner", year:1042

s1 = Style.create name:"American IPA", description:"The American IPA is a different soul from the reincarnated IPA style.
More flavorful than the withering English IPA, color can range from very pale golden to reddish amber. Hops are typically
American with a big herbal and / or citric character, bitterness is high as well. Moderate to medium bodied with a balancing
malt backbone."
s2 = Style.create name:"Baltic Porter", description:"Porters of the late 1700's were quite strong compared to todays standards,
easily surpassing 7% alcohol by volume. Some brewers made a stronger, more robust version, to be shipped across the North Sea,
dubbed a Baltic Porter. In general, the styles dark brown color covered up cloudiness and the smoky/roasted brown malts and
bitter tastes masked brewing imperfections. The addition of stale ale also lent a pleasant acidic flavor to the style, which
made it quite popular. These issues were quite important given that most breweries were getting away from pub brewing and opening
up breweries that could ship beer across the world."


b1.beers.create name:"Iso 3", style_id:1
b1.beers.create name:"Karhu", style_id:1
b1.beers.create name:"Tuplahumala", style_id:2
b2.beers.create name:"Huvila Pale Ale", style_id:1
b2.beers.create name:"X Porter", style_id:1
b3.beers.create name:"Hefeweizen", style_id:2
b3.beers.create name:"Helles", style_id:2
