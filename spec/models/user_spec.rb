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
        error_test("ニックネームを入力してください")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        error_test("Eメールを入力してください")
      end

      it '既に登録されているemailは登録できない' do
        @user2 = FactoryBot.build(:user)
        @user2.save
        @user.email = @user2.email
        error_test('Eメールはすでに存在します')
      end

      it 'emailに@がなければ登録できない' do
        @user.email = 'aaa'
        error_test('Eメールは不正な値です')
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        error_test("パスワードを入力してください")
      end

      it 'passwordが5文字以下だと登録できない' do
        @user.password = '000aa'
        @user.password_confirmation = '000aa'
        error_test('パスワードは6文字以上で入力してください')
      end

      it 'passwordが数字だけでは登録できない' do
        @user.password = '000000'
        @user.password_confirmation = '000000'
        error_test('パスワードは無効です。必ず英数字を含んでください')
      end

      it 'passwordが英字だけでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        error_test('パスワードは無効です。必ず英数字を含んでください')
      end

      it 'passwordが全角英数混合は登録できない' do
        @user.password = '０００ａａａ'
        @user.password_confirmation = '０００ａａａ'
        error_test('パスワードは無効です。必ず英数字を含んでください')
      end

      it 'password_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        error_test("パスワード（確認用）とパスワードの入力が一致しません")
      end

      it 'passwordとpassword_confirmationが一致していなければ登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'bbbbbb'
        error_test("パスワード（確認用）とパスワードの入力が一致しません")
      end

      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        error_test("姓を入力してください")
      end

      it 'last_nameが半角では登録できない' do
        @user.last_name = 'aaa'
        error_test('姓は無効です。全角で入力してください')
      end

      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        error_test("名を入力してください")
      end

      it 'first_nameが半角では登録できない' do
        @user.first_name = 'aaa'
        error_test('名は無効です。全角で入力してください')
      end

      it 'last_name_katakanaが空では登録できない' do
        @user.last_name_katakana = ''
        error_test("セイを入力してください")
      end

      it 'last_name_katakanaが半角カタカナでは登録できない' do
        @user.last_name_katakana = 'ｱｱｱ'
        error_test('セイは無効です。全角カタカナで入力してください')
      end

      it 'last_name_katakanaがカタカナ以外では登録できない' do
        @user.last_name_katakana = 'あああ'
        error_test('セイは無効です。全角カタカナで入力してください')
      end

      it 'first_name_katakanaが空では登録できない' do
        @user.first_name_katakana = ''
        error_test("メイを入力してください")
      end

      it 'first_name_katakanaが半角カタカナでは登録できない' do
        @user.first_name_katakana = 'ｱｱｱ'
        error_test('メイは無効です。全角カタカナで入力してください')
      end

      it 'first_name_katakanaがカタカナ以外では登録できない' do
        @user.first_name_katakana = 'あああ'
        error_test('メイは無効です。全角カタカナで入力してください')
      end

      it 'birthdayが空では登録できない' do
        @user.birthday = ''
        error_test("生年月日を入力してください")
      end
    end
  end
end
