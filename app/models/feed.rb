class Feed < ApplicationRecord
  validates :title, length: 3..50
  validates :url, url: true
end
