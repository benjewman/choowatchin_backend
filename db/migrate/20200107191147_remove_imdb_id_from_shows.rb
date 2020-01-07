class RemoveImdbIdFromShows < ActiveRecord::Migration[6.0]
  def change
    remove_column :shows, :imdbId, :string
  end
end
