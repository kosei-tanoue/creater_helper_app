class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.string  :name,           null: false
      t.string  :title,          null: false
      t.string  :text,           null: false
      t.integer :category_id,    null: false
      t.timestamps
    end
  end
end
