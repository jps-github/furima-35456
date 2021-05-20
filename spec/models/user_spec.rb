require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe "ユーザー新規登録" do

    it "すべての項目が存在すれば登録できる" do
      expect(@user).to be_valid
    end

    it "nicknameが空だと登録できない" do
      @user.nickname = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it "emailが空では登録できない" do
      @user.email = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "既に登録されているemailは登録できない" do
      @user.save
      @user2 = FactoryBot.build(:user)
      @user2.email = @user.email
      @user2.valid?
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

    it "emailに@がなければ登録できない" do
      @user.email = "aaa"
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end

    it "passwordが6文字以上で英数字混在であれば登録できる" do
      @user.password = "000aaa"
      @user.password_confirmation = "000aaa"
      expect(@user).to be_valid
    end

    it "passwordが空では登録できない" do
      @user.password = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it "passwordが5文字以下だと登録できない" do
      @user.password = "000aa"
      @user.password_confirmation = "000aa"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it "passwordが数字だけでは登録できない" do
      @user.password = "000000"
      @user.password_confirmation = "000000"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
    end

    it "passwordが英字だけでは登録できない" do
      @user.password = "aaaaaa"
      @user.password_confirmation = "aaaaaa"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
    end

    it "password_confirmationが空では登録できない" do
      @user.password_confirmation = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "passwordとpassword_confirmationが一致していなければ登録できない" do
      @user.password = "aaaaaa"
      @user.password_confirmation = "bbbbbb"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "last_nameが全角であれば登録できる" do
      @user.last_name = "田中"
      expect(@user).to be_valid
    end

    it "last_nameが空では登録できない" do
      @user.last_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it "last_nameが半角では登録できない" do
      @user.last_name = "aaa"
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name is invalid. Input full-width characters")
    end

    it "first_nameが全角であれば登録できる" do
      @user.first_name = "太郎"
      expect(@user).to be_valid
    end

    it "first_nameが空では登録できない" do
      @user.first_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it "first_nameが半角では登録できない" do
      @user.first_name = "aaa"
      @user.valid?
      expect(@user.errors.full_messages).to include("First name is invalid. Input full-width characters")
    end

    it "last_name_katakanaが全角カタカナであれば登録できる" do
      @user.last_name_katakana = "タナカ"
      expect(@user).to be_valid
    end

    it "last_name_katakanaが空では登録できない" do
      @user.last_name_katakana = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name katakana can't be blank")
    end

    it "last_name_katakanaが半角カタカナでは登録できない" do
      @user.last_name_katakana = "ｱｱｱ"
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name katakana is invalid. Input full-width katakana characters")
    end

    it "last_name_katakanaがカタカナ以外では登録できない" do
      @user.last_name_katakana = "あああ"
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name katakana is invalid. Input full-width katakana characters")
    end

    it "first_name_katakanaが全角カタカナであれば登録できる" do
      @user.first_name_katakana = "タロウ"
      expect(@user).to be_valid
    end

    it "first_name_katakanaが空では登録できない" do
      @user.first_name_katakana = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("First name katakana can't be blank")
    end

    it "first_name_katakanaが半角カタカナでは登録できない" do
      @user.first_name_katakana = "ｱｱｱ"
      @user.valid?
      expect(@user.errors.full_messages).to include("First name katakana is invalid. Input full-width katakana characters")
    end

    it "first_name_katakanaがカタカナ以外では登録できない" do
      @user.first_name_katakana = "あああ"
      @user.valid?
      expect(@user.errors.full_messages).to include("First name katakana is invalid. Input full-width katakana characters")
    end

    it "birthdayが空では登録できない" do
      @user.birthday = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end

  end
end