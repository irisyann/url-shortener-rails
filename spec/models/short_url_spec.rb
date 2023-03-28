require 'rails_helper'

RSpec.describe ShortUrl, type: :model do
  let(:target_url) { create(:target_url) }

  it "is valid with valid attributes" do
    short_url = build(:short_url, target_url: target_url)
    expect(short_url).to be_valid
  end

  it "is not valid without a short path" do
    short_url = build(:short_url, short_path: nil, target_url: target_url)
    expect(short_url).to_not be_valid
  end

  it "is not valid with a short path less than 6 characters" do
    short_url = build(:short_url, short_path: "aaa", target_url: target_url)
    expect(short_url).to_not be_valid
  end

  it "is not valid with a duplicate short path" do
    create(:short_url, short_path: "short123", target_url: target_url)
    short_url = build(:short_url, short_path: "short123", target_url: target_url)
    expect(short_url).to_not be_valid
  end

  it "is not valid without a target url" do
    short_url = build(:short_url, target_url: nil)
    expect(short_url).to_not be_valid
  end

  it "has a default value of 0 for num_clicks" do
    short_url = create(:short_url, target_url: target_url)
    expect(short_url.num_clicks).to eq(0)
  end
end