class CreateCalendarEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :calendar_events do |t|
      t.string :name
      t.date :event_date
      t.time :event_time
      t.string :location
      t.boolean :home, default: true

      t.timestamps
    end
  end
end
