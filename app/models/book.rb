class Book < ApplicationRecord
  before_save :titleize_name_and_author
  before_save :set_default_image_url, if: -> { image_url.blank? }
  validates :rent_price, numericality: { greater_than_or_equal_to: 0 }

  def set_default_image_url
    self.image_url ||= asset_path('Image-not-found')
  end

  def titleize_name_and_author
    self.name = name.titleize
    self.author = author.titleize
  end
end
