require 'rails_helper'
describe User do
  describe '#create' do

    #1
    it "email,passwordとpassword_confirmationが存在すれば登録できる" do
      user = build(:user)
      expect(user).to be_valid
    end

    #2
    it "emailがない場合は登録できないこと" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors.added?(:email, :blank)).to be_truthy
    end

    #3
    it "passwordがない場合は登録できないこと" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors.added?(:password, :blank)).to be_truthy
    end

    #4
    it "passwordが存在してもpassword_confirmationがない場合は登録できないこと" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end
    
    
    #5
    it "重複したemailが存在する場合登録できないこと" do
      user1 = create(:user, email: "test@test")
      user2 = build(:user, email: "test@test")
      user2.valid?
      expect(user2.errors[:email]).to include("はすでに存在します")
    end

    #6
    it "passwordが6文字以上であれば登録できること" do
      user = build(:user, password: "123456", password_confirmation: "123456")
      expect(user).to be_valid
    end

    #7
    it "passwordが5文字以下であれば登録できないこと" do
      user = build(:user, password: "12345", password_confirmation: "12345")
      user.valid?
      expect(user.errors[:password]).to include("は6文字以上で入力してください")
    end
  end
end