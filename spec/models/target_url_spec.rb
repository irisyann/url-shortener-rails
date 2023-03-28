require 'rails_helper'

RSpec.describe TargetUrl, type: :model do
  describe "validations" do
    it "is valid with a valid target_url" do
      target_url = build(:target_url)
      expect(target_url).to be_valid
    end

    it "is invalid without a target_url" do
      target_url = build(:target_url, target_url: nil)
      target_url.valid?
      expect(target_url.errors[:target_url]).to include("can't be blank")
    end

    it "is invalid with an invalid target_url" do
      target_url = build(:target_url, target_url: "example.com")
      target_url.valid?
      expect(target_url.errors[:target_url]).to include("must be a valid url")
    end
  end
end
