class AddUserIdToRequests < ActiveRecord::Migration[6.0]
  def change
    add_reference :requests, :user, foreign_key: true
  end
end
