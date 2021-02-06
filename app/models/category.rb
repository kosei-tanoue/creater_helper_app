class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '作詞依頼' },
    { id: 3, name: '作曲依頼' },
    { id: 4, name: 'イラスト依頼' },
    { id: 5, name: 'その他' },
  ]

  include ActiveHash::Associations
  has_many :requests

  end