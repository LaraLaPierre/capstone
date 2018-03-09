class AddCategoryToCalendarEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :calendar_events, :category, :integer
  end
end
