class AddShowIdToShows < ActiveRecord::Migration[6.0]
  def change
    add_column :shows, :showId, :integer
  end
end
