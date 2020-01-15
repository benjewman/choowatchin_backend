class AddMediumToReviews < ActiveRecord::Migration[6.0]
  def change
    add_column :reviews, :medium, :string
  end
end
