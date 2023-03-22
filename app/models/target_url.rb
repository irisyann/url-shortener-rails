class TargetUrl < ApplicationRecord
   
    has_many :short_urls

    validates :target_url,
        presence: true,
        format: { with: URI.regexp(%w[http https]), message: "must be a valid url" }

end
