require 'rails_helper'

RSpec.describe Feed, type: :model do
  subject { FactoryBot.create(:feed) }

  it { is_expected.to be_valid }
  it { should validate_length_of(:title).is_at_least(3) }
  it { should validate_length_of(:title).is_at_most(50) }
  it { should validate_url_of(:url) }
end
