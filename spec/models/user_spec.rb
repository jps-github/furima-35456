require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  def error_test(error_message)
    @user.valid?
    expect(@user.errors.full_messages).to include(error_message)
  end

  describe 'ユーザー新規登録' do
    context '登録できる場合' do
      it 'すべての項目が存在すれば登録できる' do
        expect(@user).to be_valid
      end

      it 'passwordが6文字以上で英数字混在であれば登録できる' do
        @user.password = '000aaa'
        @user.password_confirmation = '000aaa'
        expect(@user).to be_valid
      end

      it 'last_nameが全角であれば登録できる' do
        @user.last_name = '田中'
        expect(@user).to be_valid
      end

      it 'first_nameが全角であれば登録できる' do
        @user.first_name = '太郎'
        expect(@user).to be_valid
      end

      it 'last_name_katakanaが全角カタカナであれば登録できる' do
        @user.last_name_katakana = 'タナカ'
        expect(@user).to be_valid
      end

      it 'first_name_katakanaが全角カタカナであれば登録できる' do
        @user.first_name_katakana = 'タロウ'
        expect(@user).to be_valid
      end
    end

    context '登録できない場合' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        error_test("Nickname can't be blank")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        error_test("Email can't be blank")
      end

      it '既に登録されているemailは登録できない' do
        @user2 = FactoryBot.build(:user)
        @user2.save
        @user.email = @user2.email
        error_test('Email has already been taken')
      end

      it 'emailに@がなければ登録できない' do
        @user.email = 'aaa'
        error_test('Email is invalid')
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        error_test("Password can't be blank")
      end

      it 'passwordが5文字以下だと登録できない' do
        @user.password = '000aa'
        @user.password_confirmation = '000aa'
        error_test('Password is too short (minimum is 6 characters)')
      end

      it 'passwordが数字だけでは登録できない' do
        @user.password = '000000'
        @user.password_confirmation = '000000'
        error_test('Password is invalid. Include both letters and numbers')
      end

      it 'passwordが英字だけでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        error_test('Password is invalid. Include both letters and numbers')
      end

      it 'passwordが全角英数混合は登録できない' do
        @user.password = '０００ａａａ'
        @user.password_confirmation = '０００ａａａ'
        error_test('Password is invalid. Include both letters and numbers')
      end

      it 'password_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        error_test("Password confirmation doesn't match Password")
      end

      it 'passwordとpassword_confirmationが一致していなければ登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'bbbbbb'
        error_test("Password confirmation doesn't match Password")
      end

      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        error_test("Last name can't be blank")
      end

      it 'last_nameが半角では登録できない' do
        @user.last_name = 'aaa'
        error_test('Last name is invalid. Input full-width characters')
      end

      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        error_test("First name can't be blank")
      end

      it 'first_nameが半角では登録できない' do
        @user.first_name = 'aaa'
        error_test('First name is invalid. Input full-width characters')
      end

      it 'last_name_katakanaが空では登録できない' do
        @user.last_name_katakana = ''
        error_test("Last name katakana can't be blank")
      end

      it 'last_name_katakanaが半角カタカナでは登録できない' do
        @user.last_name_katakana = 'ｱｱｱ'
        error_test('Last name katakana is invalid. Input full-width katakana characters')
      end

      it 'last_name_katakanaがカタカナ以外では登録できない' do
        @user.last_name_katakana = 'あああ'
        error_test('Last name katakana is invalid. Input full-width katakana characters')
      end

      it 'first_name_katakanaが空では登録できない' do
        @user.first_name_katakana = ''
        error_test("First name katakana can't be blank")
      end

      it 'first_name_katakanaが半角カタカナでは登録できない' do
        @user.first_name_katakana = 'ｱｱｱ'
        error_test('First name katakana is invalid. Input full-width katakana characters')
      end

      it 'first_name_katakanaがカタカナ以外では登録できない' do
        @user.first_name_katakana = 'あああ'
        error_test('First name katakana is invalid. Input full-width katakana characters')
      end

      it 'birthdayが空では登録できない' do
        @user.birthday = ''
        error_test("Birthday can't be blank")
      end
    end
  end
end
