class CreateBooks < ActiveRecord::Migration[7.2]
  def change
    create_table :books do |t|
      t.string :author
      t.string :name
      t.decimal :rent_price
      t.boolean :is_available
      t.timestamps
    end
  end
end
