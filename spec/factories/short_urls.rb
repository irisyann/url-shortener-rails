FactoryBot.define do
    factory :short_url do

        # sequence method to generate unique values for short path attr
        sequence(:short_path) { |n| "short#{n}"}
        num_clicks { 0 }
        target_url
    end
end