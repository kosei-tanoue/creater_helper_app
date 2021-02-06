require 'rails_helper'

RSpec.describe Request, type: :model do
  before do
    @request = FactoryBot.build(:request)
  end

  describe 'リクエストの投稿' do
    context "リクエストの投稿ができる時" do
      it "全ての項目を正しく埋めていれば投稿できる" do
        expect(@request).to be_valid
      end
    end
    context "リクエストの投稿ができない時" do
      it "タイトルが空では投稿できない" do
        @request.title = ""
        @request.valid?
        expect(@request.errors.full_messages).to include("Title: 依頼のタイトルを入力してください")
      end

      it "タイトルは20文字に収めないと投稿できない" do
        @request.title = "abcdefghijelmnopqrstuvwxyz"
        @request.valid?
        expect(@request.errors.full_messages).to include("Title: 内容が長すぎます。20文字以内でお願いします")
      end

      it "テキストが空では投稿できない" do
        @request.text = ""
        @request.valid?
        expect(@request.errors.full_messages).to include("Text: 依頼の内容を入力してください")
      end

      it "テキストは255文字以内で投稿しなければならない" do
        @request.text = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
        @request.valid?
        expect(@request.errors.full_messages).to include("Text: 内容が長すぎます。255文字以内でお願いします")
      end

      it "カテゴリーを選択していなければ投稿できない" do
        @request.category_id = 1
        @request.valid?
        expect(@request.errors.full_messages).to include("Category: 依頼の種類を選択してください")
      end
    end
  end
end
