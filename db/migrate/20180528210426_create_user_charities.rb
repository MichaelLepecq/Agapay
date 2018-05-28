class CreateUserCharities < ActiveRecord::Migration[5.2]
  def change
    create_table :user_charities do |t|
      t.references :user, foreign_key: true
      t.references :charity, foreign_key: true
      t.boolean :bookmarked, default: false
      t.boolean :disliked, default: false

      t.timestamps
    end
  end
end
