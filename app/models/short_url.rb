class ShortUrl < ApplicationRecord

    validates :short_path, 
        presence: true, 
        uniqueness: true,
        length: { minimum: 6 }

    validates :num_clicks, 
        presence: true, 
        numericality: { greater_than_or_equal_to: 0 }

    belongs_to :target_url

    has_many :geolocation

    # def self.random_code
    #     code = SecureRandom.urlsafe_base64
    #     while ShortUrl.exists?(short_url: code)
    #         code = SecureRandom.urlsafe_base64
    #     end
    #     code
    # end

    # def self.create_for_user_and_long_url!(user, long_url)
    #     ShortUrl.create!(
    #         user_id: user.id,
    #         long_url: long_url,
    #         short_url: ShortUrl.random_code
    #     )
    # end

    # def num_clicks
    #     visits.count
    # end

    # def num_uniques
    #     visits.select(:user_id).distinct.count
    # end

    # def num_recent_uniques
    #     visits.select(:user_id).distinct.where("created_at > ?", 10.minutes.ago).count
    # end
end
