class AddMediumToShows < ActiveRecord::Migration[6.0]
  def change
    add_column :shows, :medium, :string
  end
end
