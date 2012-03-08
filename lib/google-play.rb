require 'open-uri'
require 'uri'
require 'nokogiri'
require 'google-play-class.rb'

# TODO: Build whitelist of types to search for and check type on submit. Also add pagination
module GooglePlay
  def self.search(query,type,page)
  	results = Array.new
  	doc = Nokogiri::HTML(open("https://play.google.com/store/search?q=#{URI.escape(query)}&c=#{URI.escape(type)}"))
		doc.css('ul.search-results-list li.search-results-item').each{ |list|
			results << SearchResult.new(query,type,list)
		}
		return results
  end
  def self.info(id,type)
		doc = Nokogiri::HTML(open("https://play.google.com/store/#{URI.escape(type)}/details?id=#{URI.escape(id)}"))
		return PlayResult.new(id,type,doc.css('h1.doc-banner-title').text)
 	end
 	def self.top(type)
 		results = Array.new
 		if type == "music"
 			url = "https://play.google.com/store/music/collection/topselling_paid_album"
 		else type == "movie"
 			url = "https://play.google.com/store/movies/collection/topselling_paid"
 		end
 		doc = Nokogiri::HTML(open(url))
 		doc.css('ul.container-snippet-list li').each{ |list|
 			results << TopResult.new(type,list)
 		}
 		return results
 	end
end