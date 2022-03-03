class BookTag < ApplicationRecord
  belongs_to :book
  belongs_to :tag
  # 組み合わせの同じタグは作れない
  validates :book_id, :uniqueness => { :scope => :tag_id }
end
