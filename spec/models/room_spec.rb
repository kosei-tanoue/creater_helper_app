require 'rails_helper'

RSpec.describe Room, type: :model do
  before do
    @room = FactoryBot.build(:room)
  end
  describe 'ルームが生成できる時' do
    it 'nameを決めていれば部屋が生成できる' do
      expect(@room).to be_valid
    end
  end

  describe 'ルームが生成できない時' do
    it 'nameの値が存在しなければ部屋を生成できない' do
      @room.name = nil
      @room.valid?
      expect(@room.errors.full_messages).to include("Nameが空です。ルーム名を入力してください")
    end
  end
end
