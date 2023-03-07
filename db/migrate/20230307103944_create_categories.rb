class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.integer :category_type, default: 1
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :categories, %i[name category_type user_id], unique: true
  end
end
