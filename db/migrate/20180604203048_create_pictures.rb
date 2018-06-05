class CreatePictures < ActiveRecord::Migration[5.2]
  def change
    create_table :pictures do |t|
      t.references :charity, foreign_key: true
      t.string :image_url

      t.timestamps
    end
  end
end
