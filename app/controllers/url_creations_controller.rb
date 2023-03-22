require 'open-uri'
require 'nokogiri'

class  UrlCreationsController < ApplicationController
    after_action :get_geolocation, only: [:redirect]

    def new
        @target_url = TargetUrl.new
    end

    def create
        @target_url = TargetUrl.new(url_params)

        # check if target url is valid
        if @target_url.valid?

            # check if target url already exists for current user
            if TargetUrl.find_by(user_id: Current.user.id, target_url: @target_url.target_url).present?
                @target_url = TargetUrl.find_by(user_id: Current.user.id, target_url: @target_url.target_url)

            else
                # if target url is new, create and save new target url
                @target_url.title_tag = get_title_tag(@target_url.target_url)
                @target_url.user_id = Current.user.id
                @target_url.save

            end
        
            # create and save new short url
            @short_url = @target_url.short_urls.create(short_path: SecureRandom.hex(3))
            @short_url.save

            redirect_to usage_report_path, notice: "Your URL has been shortened!"
        else
            # if target url is not valid, render new page
            render :new
        end
    end

    def redirect
        # find short url
        @short_url = ShortUrl.find_by(short_path: params[:short_path])

        # if short url exists, redirect to target url
        if @short_url.present?
            @short_url.update(num_clicks: @short_url.num_clicks + 1)
            @target_url = TargetUrl.find_by(id: @short_url.target_url_id)
            redirect_to @target_url.target_url, allow_other_host: true

        else
            # if short url does not exist, render error page
            render :error
        end
    end

    def get_geolocation
        # use Geocoder gem
        city = request.location.city
        country = request.location.country
        @short_url.geolocation.create(city: city, country: country)
        
    end

    # Retrieve title tag of URL
    def get_title_tag(url)
        begin
            doc = Nokogiri::HTML(URI.open(url))
            title_tag = doc.at_css("title").text
        rescue => e
            title_tag = "(No title found)"
        end

    end


    private
    def url_params
        params.require(:target_url).permit(:target_url)
    end
end
