class Tag < ApplicationRecord
  belongs_to :user
  has_many :book_tags, dependent: :destroy
  has_many :books, through: :book_tags

  validates :name, presence: true
  validates :name, uniqueness: true

end
