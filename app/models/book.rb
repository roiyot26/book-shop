class Book < ApplicationRecord
  before_save :titleize_name_and_author
  before_save :set_default_image_url, if: -> { image_url.blank? }
  validates :rent_price, numericality: { greater_than_or_equal_to: 0 }

  # private

  def set_default_image_url
    self.image_url ||= 'assets/images/hp7.png'
  end

  private

  def titleize_name_and_author
    self.name = name.titleize
    self.author = author.titleize
  end
end
