require 'open-uri'
require 'nokogiri'

class PlayResult
	attr_accessor :id, :type, :title, :price, :rating, :description, :thumbnail, :actors, :lengthtime, :contentrating, :genre, :related

	def initialize(id,type,title)
		@id=id
		@type=type
		@title=title
		@price=""
		@rating=""
		@description=""
		@thumbnail=""
		@actors=Array.new
		@lengthtime=""
		@contentrating=""
		@genre=""
		@related=Array.new
		fillPlayData(id,type,title)
	end

	def fillPlayData(id,type,title)
		doc = Nokogiri::HTML(open("https://play.google.com/store/#{type}/details?id=#{id}"))
		get_price(doc)
		get_rating(doc)
		get_description(doc)
		get_thumbnail(doc)
		get_actors(doc)
		get_lengthtime(doc)
		get_contentrating(doc)
		get_genre(doc)
		get_related(doc)
	end
	def get_title(doc)
		if @title == ""
			@title = doc.css('div.doc-header-content h1.doc-header-title').text
		end
	end
	def get_price(doc)
		if doc.css('.buy-wrapper .buy-border a.buy-link .buy-button-price').length != 0
			@price = doc.css('.buy-wrapper .buy-border a.buy-link .buy-button-price')[0].text
		end
	end

	def get_rating(doc)
		if doc.css('.doc-details-ratings-price div div.ratings').length != 0
			@rating = doc.css('.doc-details-ratings-price div div.ratings')[0]['title']
		end
	end

	def get_description(doc)
		if doc.css('div#doc-original-text').length != 0
			@description = doc.css('div#doc-original-text').text
		end
	end

	def get_thumbnail(doc)
		if doc.css('div.doc-banner-icon img').length != 0
			@thumbnail = doc.css('div.doc-banner-icon img')[0]['src']
		end
	end

	def get_actors(doc)
		if doc.css('td.credit-cell span[itemprop=actors] a span').length != 0
			doc.css('td.credit-cell span[itemprop=actors] a span').each{ |value|
				@actors << value.text.to_s
			}
		end
	end

	def get_lengthtime(doc)
		if doc.css('dl.doc-metadata-list dd').length != 0
			doc.css('dl.doc-metadata-list dd').each{ |value|
				if value.text.to_s =~ /minutes/
					@lengthtime = value.text.to_s
				end
			}
		end
	end

	def get_contentrating(doc)
		if doc.css('dd[itemprop=contentRating]').length != 0
			@contentrating = doc.css('dd[itemprop=contentRating]').text
		end
	end

	def get_genre(doc)
		if doc.css('ul.doc-genres .doc-genre-link a:first-child').length != 0
			@genre = doc.css('ul.doc-genres .doc-genre-link a:first-child').text
		end
	end

	def get_related(doc)
		if doc.css('div#related-list ul.snippet-list li div div.details a.title').length != 0
			doc.css('div#related-list ul.snippet-list li div div.details a.title').each{ |value|
				@related << value.text.to_s
			}
		end
	end
end