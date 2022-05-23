require 'rails_helper'

describe Book do
    describe '#create' do
        before do 
            user = create(:user)
        end
      #1
      it "title,user_idが存在すれば登録できる" do
        book = build(:book)
        expect(book).to be_valid
      end

      #2
      it "titleがない場合は登録できないこと" do
        book = build(:book, title: nil)
        book.valid?
        expect(book.errors.added?(:title, :blank)).to be_truthy
      end

      #3
      it "titleが重複する場合登録できないこと" do
        book1 = create(:book, title: "RSpec")
        book2 = build(:book, title: "RSpec")
        book2.valid?
        expect(book2.errors[:title]).to include("はすでに存在します")
      end
    end
end