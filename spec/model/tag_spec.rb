require 'rails_helper'

describe Tag do
    describe '#create' do
        before do 
            user = create(:user)
        end
      #1
      it "name,user_idが存在すれば登録できる" do
        tag = build(:tag)
        expect(tag).to be_valid
      end

      #2
      it "nameがない場合は登録できないこと" do
        tag = build(:tag, name: nil)
        tag.valid?
        expect(tag.errors.added?(:name, :blank)).to be_truthy
      end

      #3
      it "nameが重複する場合登録できないこと" do
        tag1 = create(:tag, name: "RSpec")
        tag2 = build(:tag, name: "RSpec")
        tag2.valid?
        expect(tag2.errors[:name]).to include("はすでに存在します")
      end
    end
end