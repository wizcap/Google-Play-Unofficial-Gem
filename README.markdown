# Google Play Unofficial Gem

A gem to pull movie, music and book data from Google Play, it was built with Nokogiri

## Dependencies

* Nokogiri

# How to install

	gem install google-play

## Examples
	require 'rubygems'
	require 'google-play'

	GooglePlay.top("movie").each{ |movie|
		puts movie.title
	}