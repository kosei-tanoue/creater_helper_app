class Request < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category

  with_options presence: true do
    validates :title, length: { maximum: 20 , message: ': 内容が長すぎます。20文字以内でお願いします' }, presence: { message: ': 依頼のタイトルを入力してください' }
    validates :text, length: { maximum: 255 , message: ': 内容が長すぎます。255文字以内でお願いします'}, presence: { message: ': 依頼の内容を入力してください' }
    validates :category_id, numericality: { other_than: 1, message: ': 依頼の種類を選択してください'}
  end

end
