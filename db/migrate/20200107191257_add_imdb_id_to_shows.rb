class AddImdbIdToShows < ActiveRecord::Migration[6.0]
  def change
    add_column :shows, :imdbID, :string
  end
end
