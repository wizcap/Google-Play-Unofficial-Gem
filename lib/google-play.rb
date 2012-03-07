require 'open-uri'
require 'uri'
require 'nokogiri'
require './google-play-class.rb'
require "awesome_print"

module GooglePlay
  def self.search(query,type,page)
  	results = Array.new
  	doc = Nokogiri::HTML(open("https://play.google.com/store/search?q=#{URI.escape(query)}&c=#{type}"))
		doc.css('ul.search-results-list li.search-results-item').each{ |list|
			results << SearchResult.new(query,type,list)
		}
		return results
  end
  def self.info(id,type)
		doc = Nokogiri::HTML(open("https://play.google.com/store/#{type}/details?id=#{id}"))
		return PlayResult.new(id,type,doc.css('h1.doc-banner-title').text)
 	end
end

#ap GooglePlay.info("B2bigmdzursbckmnhfgmjdwscyy", "music/album")
#ap GooglePlay.search("test","books",0)