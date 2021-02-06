require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe "ユーザー新規登録" do
    context '新規登録できる時' do
      it '全ての要素を正しく埋めていれば登録できる' do
        expect(@user).to be_valid
      end

      it 'nicknameが6文字以下であれば登録できる' do
        @user.nickname = "aaaaa"
        expect(@user).to be_valid
      end

      it 'passwordとpassword_confirmationが6文字以上であれば登録できる' do
        @user.password = "aaaaaa"
        @user.password_confirmation = "aaaaaa"
        expect(@user).to be_valid
      end
      
    end
    context '新規登録出来ない時' do
      it "nicknameが空だと登録出来ない" do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "Nicknameを入力してください"
      end
  
      it "nicknameが6文字以上だと登録出来ない" do
        @user.nickname = "aaaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include "Nicknameが長すぎます"
      end
  
      it "emailが空では登録出来ない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "Eメールを入力してください"
      end
  
      it "passwordが空では登録出来ない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードを入力してください", "パスワード（確認用）とパスワードの入力が一致しません"
      end
  
      it "password_confirmationが正しくなければ登録出来ない" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワード（確認用）とパスワードの入力が一致しません"
      end

      it "重複したemailが存在する場合登録できない" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include "Eメールはすでに存在します"
      end

      it "passwordが5文字以下では登録できない" do
        @user.password = "00000"
        @user.password_confirmation = "00000"
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードは6文字以上で入力してください"
      end
    end
  end
end
