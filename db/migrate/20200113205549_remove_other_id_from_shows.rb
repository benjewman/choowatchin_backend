class RemoveOtherIdFromShows < ActiveRecord::Migration[6.0]
  def change

    remove_column :shows, :imdbID, :string
  end
end
