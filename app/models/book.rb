class Book < ApplicationRecord
  belongs_to :user
  has_many:book_tags, dependent: :destroy
  has_many:tags, through: :book_tags
  accepts_nested_attributes_for :book_tags
  
  validates :title, presence: true, uniqueness: { scope: :user }
  default_scope -> { order(created_at: :desc) }
  
  
   def self.looks(search, keyword)
    if search == "perfect_match"
      @books = Book.where("title LIKE?","#{keyword}")
    elsif search == "partial_match"
       if keyword.blank?
         @books = nil
       else
       @books = Book.where("title LIKE?","%#{keyword}%")
       end
    else
      @books = Book.all
    end
   end
end
