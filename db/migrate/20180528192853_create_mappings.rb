class CreateMappings < ActiveRecord::Migration[5.2]
  def change
    create_table :mappings do |t|
      t.references :category, foreign_key: true
      t.references :charity, foreign_key: true

      t.timestamps
    end
  end
end
