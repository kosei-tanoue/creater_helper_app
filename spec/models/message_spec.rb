require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @message = FactoryBot.build(:message)
  end
  describe 'チャットの生成' do
    context 'チャットのメッセージが送信できる時' do
      it '全ての要素を正しく埋めていれば投稿できる' do
        expect(@message).to be_valid
      end

      it 'contentが空でも投稿できる' do
        @message.content = nil
        expect(@message).to be_valid
      end

      it 'imageが空でも投稿できる' do
        @message.image = nil
        expect(@message).to be_valid
      end
    end

    context 'チャットのメッセージが送信できない時' do
      it 'contentとimageが空では投稿できない' do
        @message.content = nil
        @message.image = nil
        @message.valid?
        expect(@message.errors.full_messages).to include("Contentを入力してください")
      end
    end
  end
end
