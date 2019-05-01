class CreateRsvpEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :rsvp_events do |t|
      t.integer :participant_id
      t.integer :attending_event_id

      t.timestamps
    end
  end
end
