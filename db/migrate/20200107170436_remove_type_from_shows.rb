class RemoveTypeFromShows < ActiveRecord::Migration[6.0]
  def change
    remove_column :shows, :type, :string
  end
end
