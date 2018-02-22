class AddCategoryIdToCalendarEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :calendar_events, :category_id, :string
  end
end
