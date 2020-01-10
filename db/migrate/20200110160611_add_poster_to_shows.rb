class AddPosterToShows < ActiveRecord::Migration[6.0]
  def change
    add_column :shows, :poster, :string
  end
end
