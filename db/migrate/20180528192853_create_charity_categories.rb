class CreateCharityCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :charity_categories do |t|
      t.references :category, foreign_key: true
      t.references :charity, foreign_key: true

      t.timestamps
    end
  end
end
