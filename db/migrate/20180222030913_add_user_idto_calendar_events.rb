class AddUserIdtoCalendarEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :calendar_events, :user_id, :integer
  end
end
