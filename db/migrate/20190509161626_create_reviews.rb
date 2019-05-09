class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :reviewer_id
      t.integer :reviewing_event_id
      t.text :body

      t.timestamps
    end
    add_index :reviews, [:reviewer_id, :reviewing_event_id]
  end
end
