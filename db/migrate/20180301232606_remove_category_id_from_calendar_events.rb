class RemoveCategoryIdFromCalendarEvents < ActiveRecord::Migration[5.1]
  def change
    remove_column :calendar_events, :category_id, :integer
  end
end
