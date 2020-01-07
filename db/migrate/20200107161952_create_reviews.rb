class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.string :stamp
      t.string :content
      t.integer :user_id
      t.integer :show_id

      t.timestamps
    end
  end
end
