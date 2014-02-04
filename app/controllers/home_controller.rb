class HomeController < ApplicationController
require 'nokogiri'
require 'open-uri'
require 'will_paginate/array'

	def index
	   if request.xhr?
	        valid_url = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix =~ params[:url]
	        unless valid_url.blank?
			image = []
			doc = Nokogiri::HTML(open(params['url']))
			doc.xpath('//img').each do |link|
			    image << link.attributes["src"].value
		        end
		    @title = doc.xpath('//title').children.text()
		    @image_list = image.paginate(:page => params[:page], :per_page => 5)
		else
		  render :js => "jQuery('#pagination').html(''); jQuery('#result').html('Nothing to dispaly')"
		end
           end
	end
end
