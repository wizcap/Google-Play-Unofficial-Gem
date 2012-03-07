require 'open-uri'
require 'nokogiri'
require './google-play-class.rb'

module GooglePlay
  def self.info(id, type)
		doc = Nokogiri::HTML(open("https://play.google.com/store/#{type}/details?id=#{id}"))
		return PlayResult.new(id,type,doc.css('h1.doc-banner-title').text)
 	end
end

#usage GooglePlay.info("B2bigmdzursbckmnhfgmjdwscyy", "music/album")