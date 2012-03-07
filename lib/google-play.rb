require 'open-uri'
require 'nokogiri'
require './google-play-class.rb'
require "awesome_print"

module GooglePlay
  def self.search(query, type)
  	returnarray = ["query" => query, "type" => type]
		doc = Nokogiri::HTML(open("https://play.google.com/store/search?q=#{query}&c=#{type}"))
		doc.css('li.search-results-item').each{ |links|
			temparray = ["title" => links.css('a.title').text]
			returnarray << temparray
		}
		return returnarray
  end
  def self.info(id, type)
		doc = Nokogiri::HTML(open("https://play.google.com/store/#{type}/details?id=#{id}"))
		return PlayResult.new(id,type,doc.css('h1.doc-banner-title').text)
 	end
end

ap GooglePlay.info("B2bigmdzursbckmnhfgmjdwscyy", "music/album")