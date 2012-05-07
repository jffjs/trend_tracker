class AddLocationToTrends < ActiveRecord::Migration
  def change
    add_column :trends, :location,  :string
    # these are needed for geocoder gem
    add_column :trends, :latitude,  :float
    add_column :trends, :longitude, :float
  end
end
