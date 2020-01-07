class CreateShows < ActiveRecord::Migration[6.0]
  def change
    create_table :shows do |t|
      t.string :type
      t.string :title
      t.string :year
      t.string :imdbId

      t.timestamps
    end
  end
end
