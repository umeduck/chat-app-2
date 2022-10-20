class Message < ApplicationRecord

  validates :content, presence: true, unless: :was_attached?

  belongs_to :room
  belongs_to :user
  has_one_attached :image

  def was_attached?
    self.image.attached?
  end
  
end
