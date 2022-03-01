class Book < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true
  
  def self.search(keyword)
  where(["title like? OR body like?", "%#{keyword}%", "%#{keyword}%"])
  end
end
