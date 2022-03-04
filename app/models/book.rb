class Book < ApplicationRecord
  belongs_to :user
  has_many:book_tags, dependent: :destroy
  has_many:tags, through: :book_tags
  accepts_nested_attributes_for :book_tags
  
  validates :title, presence: true, uniqueness: { scope: :user }
  default_scope -> { order(created_at: :desc) }
  
  
  def self.search(keyword)
  where(["title like? OR body like?", "%#{keyword}%", "%#{keyword}%"])
  end
end
