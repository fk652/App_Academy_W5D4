require "securerandom"

# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint           not null, primary key
#  long_url   :string           not null
#  short_url  :string           not null
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ShortenedUrl < ApplicationRecord

  def self.random_code
    random_url = SecureRandom.urlsafe_base64 until !self.exists?(:short_url => random_url)
    random_url
  end

  validates :long_url, presence: true
  validates :long_url, uniqueness: true

  validates :short_url, presence: true
  validates :short_url, uniqueness: true

  validates :user_id, presence: true

  after_initialize do |shortened_url|
    generate_short_url if new_record?
  end

  

  private 
  def generate_short_url
    self.short_url = ShortenedUrl.random_code if !self.short_url
  end
end
