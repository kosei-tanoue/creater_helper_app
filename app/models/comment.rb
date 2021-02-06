class Comment < ApplicationRecord
  

  belongs_to :user
  belongs_to :request

  validates :text, presence: true
end

