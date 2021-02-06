class Room < ApplicationRecord
  has_many :room_users, dependent: :destroy
  has_many :users, through: :room_users
  has_many :messages, dependent: :destroy

  validates :name, presence: { message: "が空です。ルーム名を入力してください" }

end
