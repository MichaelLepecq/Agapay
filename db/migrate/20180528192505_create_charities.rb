class CreateCharities < ActiveRecord::Migration[5.2]
  def change
    create_table :charities do |t|
      t.string :name
      t.string :city
      t.string :province
      t.string :business_number
      t.text :description
      t.string :logo
      t.string :picture

      t.timestamps
    end
  end
end
