class AddCoordinatesToCharity < ActiveRecord::Migration[5.2]
  def change
    add_column :charities, :latitude, :float
    add_column :charities, :longitude, :float
  end
end
