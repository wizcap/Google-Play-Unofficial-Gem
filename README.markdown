# Google Play Unofficial Gem

A gem to pull movie, music and book data from Google Play, it was built with Nokogiri

## Dependencies

* Nokogiri

## Known issues

* The gem is useless if you or your server is located outside the US since the play store is not accessible in those locations

# How to install

	gem install google-play

## Examples
#Get top movies and list their titles
	require 'rubygems'
	require 'google-play'

	GooglePlay.top("movie").each{ |movie|
		puts movie.title
	}
	
#Search for a query and display results
	require 'rubygems'
	require 'google-play'

	GooglePlay.search("Tim & Eric", "movies", 0).each{ |movie|
 	   puts "#{movie.title} - #{movie.rating}"
	}

#Get single movie info
	require 'rubygems'
	require 'google-play'
	require 'awesome_print'

	movieinfo = GooglePlay.info("rAl1OjoWNvY", "movies")
	ap movieinfo