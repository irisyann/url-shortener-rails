require 'open-uri'
require 'nokogiri'

class  UrlCreationsController < ApplicationController
    before_action :get_geolocation, :update_num_clicks, only: [:redirect]

    def index
        # get all urls for current user
        @target_urls = TargetUrl.where(user_id: Current.user.id)
    end

    def new
        @target_url = TargetUrl.new
    end

    def create
        # Find an existing TargetUrl with the specified target_url or initialise a new one if none exists
        @target_url = TargetUrl.find_or_initialize_by(user_id: Current.user.id, target_url: url_params[:target_url])
        @target_url.user_id = Current.user.id
        @target_url.title_tag = get_title_tag(url_params[:target_url])

        # If the TargetUrl object is new, save it to the database
        if @target_url.new_record?
          @target_url.save
        end
      
        @custom_slug = url_params[:custom_slug]
      
        # If a custom slug was specified in the form submission
        if @custom_slug.present?

            if !valid_short_path?(@custom_slug)
                flash[:danger] = "Invalid custom slug. Only alphanumeric characters are allowed and it must be within 6 to 15 characters."
                # @target_url.errors.add(:base, "Invalid custom slug. Only alphanumeric characters are allowed and it must be within 6 to 15 characters.")
                redirect_to new_url_creation_path(target_url: @target_url.target_url, custom_slug: @custom_slug)


            elsif duplicate_short_path_exists?(@custom_slug)
                flash[:danger] = "A shortened URL with the same custom slug is taken. Please try again."
                # @target_url.errors.add(:base, "A shortened URL with the same custom slug is taken. Please try again.")
                redirect_to new_url_creation_path(target_url: @target_url.target_url, custom_slug: @custom_slug)

            else

                if @target_url.save
                    @short_url = @target_url.short_urls.build(short_path: @custom_slug)

                    if @short_url.valid?
                        @short_url.save
                        redirect_to url_creations_path, notice: "Your URL has been shortened!"
                    else
                        @target_url.errors.add(:base, "There was an error while creating the short URL. Please try again.")
                        render :new
                    end

                else
                    @target_url.errors.add(:base, "There was an error while creating the short URL. Please try again.")
                    render :new

                end
            end
        else
          
            if @target_url.save
                @short_url = @target_url.short_urls.build(short_path: generate_random_short_path)

                if @short_url.valid?
                    @short_url.save
                    redirect_to url_creations_path, notice: "Your URL has been shortened!"
                else
                    @target_url.errors.add(:base, "There was an error while creating the short URL. Please try again.")
                    render :new
                end
            else
                @target_url.errors.add(:base, "There was an error while creating the short URL. Please try again.")
                render :new
            end
        end
        
      rescue ActiveRecord::RecordInvalid => e
        # If there was an error while saving the TargetUrl or ShortUrl record, add the error message to the TargetUrl object's errors and render the 'new' view
        @target_url.errors.add(:target_url, e.message)
        render :new
      end
      

    def redirect
        # find short url
        @short_url = ShortUrl.find_by(short_path: params[:short_path])

        # if short url exists, redirect to target url
        if @short_url.present?
            @target_url = TargetUrl.find_by(id: @short_url.target_url_id)
            redirect_to @target_url.target_url, allow_other_host: true
            return

        else
            # if short url does not exist, render error page
            render 'main/error'
        end
    end

    def show
        @short_url = ShortUrl.find_by(short_path: params[:id])
    end

    private

        # Check valid short path of minimum 6 chars and maximum 15 chars with only alphanumeric characters
        def valid_short_path?(short_path)
            if (short_path.length >= 6 && short_path.length <= 15 && short_path.match?(/\A[a-zA-Z0-9]+\z/))
                true
            else
                false
            end
        end

        # Check for duplicate short path
        def duplicate_short_path_exists?(short_path)
            if ShortUrl.find_by(short_path: short_path).present?
                true
            else
                false
            end
        end

        # Generate random short path
        def generate_random_short_path
            short_path = SecureRandom.hex(3)
            if duplicate_short_path_exists?(short_path)
                generate_random_short_path
            else
                short_path
            end
        end

        # Increment and update number of clicks on short url
        def update_num_clicks
            if @short_url.present?
                @short_url.increment!(:num_clicks)
            end
        end

        # Retrieve geolocation of user
        def get_geolocation
            # use Geocoder gem
            if @short_url.present?
                city = request.location.city
                country = request.location.country
                @short_url.geolocation.create(city: city, country: country)
            end
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


        def url_params
            params.require(:target_url).permit(:target_url, :custom_slug)
        end
end
