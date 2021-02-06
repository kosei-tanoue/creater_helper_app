require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  describe 'コメントが投稿' do
    context "コメントの投稿ができる時" do
      it 'コメントを入力していれば投稿することができる' do
        expect(@comment).to be_valid
      end
    end
    context "コメントの投稿ができない時" do
      it 'textが空では投稿できない' do
        @comment.text = ""
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Textを入力してください")
      end

      it 'ユーザーが紐づいていないければ投稿することができない' do
        @comment.user = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Userを入力してください")
      end

      it 'リクエストが紐づいていないければ投稿することができない' do
        @comment.request = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Requestを入力してください")
      end
    end
  end

end
