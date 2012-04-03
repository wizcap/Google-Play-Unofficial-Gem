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
		@@doc = Nokogiri::HTML(open("https://play.google.com/store/#{type}/details?id=#{id}"))
		get_price()
		get_rating()
		get_description()
		get_thumbnail()
		get_actors()
		get_lengthtime()
		get_contentrating()
		get_genre()
		get_related()
	end
	
	def get_title()
		if @title == ""
			@title = @@doc.css('div.doc-header-content h1.doc-header-title').text
		end
	end
	def get_price()
		if @@doc.css('.buy-wrapper .buy-border a.buy-link .buy-button-price').length != 0
			@price = @@doc.css('.buy-wrapper .buy-border a.buy-link .buy-button-price')[0].text
		end
	end

	def get_rating()
		if @@doc.css('.doc-details-ratings-price div div.ratings').length != 0
			@rating = @@doc.css('.doc-details-ratings-price div div.ratings')[0]['title']
		end
	end

	def get_description()
		if @@doc.css('div#doc-original-text').length != 0
			@description = @@doc.css('div#doc-original-text').text
		end
	end

	def get_thumbnail()
		if @@doc.css('div.doc-banner-icon img').length != 0
			@thumbnail = @@doc.css('div.doc-banner-icon img')[0]['src']
		end
	end

	def get_actors()
		if @@doc.css('td.credit-cell span[itemprop=actors] a span').length != 0
			@@doc.css('td.credit-cell span[itemprop=actors] a span').each{ |value|
				@actors << value.text.to_s
			}
		end
	end

	def get_lengthtime()
		if @@doc.css('dl.doc-metadata-list dd').length != 0
			@@doc.css('dl.doc-metadata-list dd').each{ |value|
				if value.text.to_s =~ /minutes/
					@lengthtime = value.text.to_s
				end
			}
		end
	end

	def get_contentrating()
		if @@doc.css('dd[itemprop=contentRating]').length != 0
			@contentrating = @@doc.css('dd[itemprop=contentRating]').text
		end
	end

	def get_genre()
		if @@doc.css('ul.doc-genres .doc-genre-link a:first-child').length != 0
			@genre = @@doc.css('ul.doc-genres .doc-genre-link a:first-child').text
		end
	end

	def get_related()
		if @@doc.css('div#related-list ul.snippet-list li div div.details a.title').length != 0
			@@doc.css('div#related-list ul.snippet-list li div div.details a.title').each{ |value|
				@related << value.text.to_s
			}
		end
	end
end

class SearchResult
	attr_accessor :id, :type, :title, :price, :rating, :description, :thumbnail

	def initialize(query,type,list)
		@id=""
		@type=type
		@title=""
		@price=""
		@rating=""
		@description=""
		@thumbnail=""
		fillSearchData(query,type,list)
	end

	def fillSearchData(id,type,list)
		get_id(list)
		get_title(list)
		get_price(list)
		get_rating(list)
		get_description(list)
		get_thumbnail(list)
	end

	def get_id(doc)
		@id = doc['data-docid']
	end

	def get_title(doc)
		if doc.css('a.title').length != 0
			@title = doc.css('a.title').text
		end
	end

	def get_price(doc)
		if doc.css('span.buy-button-price').length != 0
			@price = doc.css('span.buy-button-price').text
		end
	end

	def get_rating(doc)
		if doc.css('div.ratings-wrapper .ratings').length != 0
			@rating = doc.css('div.ratings-wrapper .ratings')[0]['title']
		else
			@rating = "None"
		end
	end

	def get_description(doc)
		if doc.css('div.description').length != 0
			@description = doc.css('div.description').text
		end
	end

	def get_thumbnail(doc)
		if doc.css('.thumbnail-wrapper .thumbnail img').length != 0
			@thumbnail = doc.css('.thumbnail-wrapper .thumbnail img')[0]['src']
		end
	end
end

class TopResult
	attr_accessor :id, :type, :title, :price, :artist, :explicit, :thumbnail

	def initialize(type,list)
		@id=""
		@type=type
		@title=""
		@price=""
		if type == "music" then @artist="" end
		@explicit=""
		@thumbnail=""
		fillSearchData(type,list)
	end

	def fillSearchData(type,list)
		get_id(list)
		get_title(list)
		get_price(list)
		get_artist(list)
		get_explicit(list)
		get_thumbnail(list)
	end

	def get_id(doc)
		@id = doc['data-docid']
	end

	def get_title(doc)
		if doc.css('a.title').length != 0
			@title = doc.css('a.title')[0]['title']
		end
	end

	def get_price(doc)
		if doc.css('span.buy-button-price').length != 0
			@price = doc.css('span.buy-button-price').text
		end
	end

	def get_artist(doc)
		if doc.css('span.attribution div a').length != 0
			@artist = doc.css('span.attribution div a').text
		end
	end

	def get_explicit(doc)
		if doc.css('.explicit').length != 0
			@explicit = 1
		end
	end

	def get_thumbnail(doc)
		if doc.css('.thumbnail-wrapper .thumbnail img').length != 0
			@thumbnail = doc.css('.thumbnail-wrapper .thumbnail img')[0]['src']
		end
	end
end