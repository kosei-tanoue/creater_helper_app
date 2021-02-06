class RemoveNameFromRequests < ActiveRecord::Migration[6.0]
  def change
    remove_column :requests, :name, :string
  end
end
