irb(main):008:0> **brewdog = Brewery.create name:"BrewDog", year:2007**
   (0.2ms)  begin transaction
  SQL (0.5ms)  INSERT INTO "breweries" ("name", "year", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["name", "BrewDog"], ["year", 2007], ["created_at", "2016-01-28 18:49:29.997793"], ["updated_at", "2016-01-28 18:49:29.997793"]]
   (4.2ms)  commit transaction
=> #<Brewery id: 5, name: "BrewDog", year: 2007, created_at: "2016-01-28 18:49:29", updated_at: "2016-01-28 18:49:29">
irb(main):015:0> **punk = Beer.create name:"Punk IPA", style:"IPA", brewery_id:5**
   (0.2ms)  begin transaction
  SQL (0.6ms)  INSERT INTO "beers" ("name", "style", "brewery_id", "created_at", "updated_at") VALUES (?, ?, ?, ?, ?)  [["name", "Punk IPA"], ["style", "IPA"], ["brewery_id", 5], ["created_at", "2016-01-28 18:55:47.686297"], ["updated_at", "2016-01-28 18:55:47.686297"]]
   (7.9ms)  commit transaction
=> #<Beer id: 14, name: "Punk IPA", style: "IPA", brewery_id: 5, created_at: "2016-01-28 18:55:47", updated_at: "2016-01-28 18:55:47">
irb(main):016:0> **nanny = Beer.create name:"Nanny State", style:"lowalcohol", brewery_id:5**
   (0.2ms)  begin transaction
  SQL (0.4ms)  INSERT INTO "beers" ("name", "style", "brewery_id", "created_at", "updated_at") VALUES (?, ?, ?, ?, ?)  [["name", "Nanny State"], ["style", "lowalcohol"], ["brewery_id", 5], ["created_at", "2016-01-28 18:57:21.124161"], ["updated_at", "2016-01-28 18:57:21.124161"]]
   (7.6ms)  commit transaction
=> #<Beer id: 15, name: "Nanny State", style: "lowalcohol", brewery_id: 5, created_at: "2016-01-28 18:57:21", updated_at: "2016-01-28 18:57:21">
irb(main):017:0> **punk.ratings.create score:10**
   (0.2ms)  begin transaction
  SQL (0.2ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 10], ["beer_id", 14], ["created_at", "2016-01-28 18:58:37.440461"], ["updated_at", "2016-01-28 18:58:37.440461"]]
   (6.5ms)  commit transaction
=> #<Rating id: 4, score: 10, beer_id: 14, created_at: "2016-01-28 18:58:37", updated_at: "2016-01-28 18:58:37">
irb(main):018:0> **punk.ratings.create score:12**
   (0.2ms)  begin transaction
  SQL (0.4ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 12], ["beer_id", 14], ["created_at", "2016-01-28 18:58:50.613444"], ["updated_at", "2016-01-28 18:58:50.613444"]]
   (20.9ms)  commit transaction
=> #<Rating id: 5, score: 12, beer_id: 14, created_at: "2016-01-28 18:58:50", updated_at: "2016-01-28 18:58:50">
irb(main):019:0> **punk.ratings.create score:14**
   (0.2ms)  begin transaction
  SQL (0.3ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 14], ["beer_id", 14], ["created_at", "2016-01-28 18:58:53.569051"], ["updated_at", "2016-01-28 18:58:53.569051"]]
   (17.4ms)  commit transaction
=> #<Rating id: 6, score: 14, beer_id: 14, created_at: "2016-01-28 18:58:53", updated_at: "2016-01-28 18:58:53">
irb(main):020:0> **nanny.ratings.create score:14**
   (0.2ms)  begin transaction
  SQL (0.4ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 14], ["beer_id", 15], ["created_at", "2016-01-28 18:59:05.909803"], ["updated_at", "2016-01-28 18:59:05.909803"]]
   (4.5ms)  commit transaction
=> #<Rating id: 7, score: 14, beer_id: 15, created_at: "2016-01-28 18:59:05", updated_at: "2016-01-28 18:59:05">
irb(main):021:0> **nanny.ratings.create score:12**
   (0.2ms)  begin transaction
  SQL (0.4ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 12], ["beer_id", 15], ["created_at", "2016-01-28 18:59:07.992719"], ["updated_at", "2016-01-28 18:59:07.992719"]]
   (7.1ms)  commit transaction
=> #<Rating id: 8, score: 12, beer_id: 15, created_at: "2016-01-28 18:59:07", updated_at: "2016-01-28 18:59:07">
irb(main):022:0> **nanny.ratings.create score:19**
   (0.2ms)  begin transaction
  SQL (0.5ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 19], ["beer_id", 15], ["created_at", "2016-01-28 18:59:11.114790"], ["updated_at", "2016-01-28 18:59:11.114790"]]
   (7.5ms)  commit transaction
=> #<Rating id: 9, score: 19, beer_id: 15, created_at: "2016-01-28 18:59:11", updated_at: "2016-01-28 18:59:11">
