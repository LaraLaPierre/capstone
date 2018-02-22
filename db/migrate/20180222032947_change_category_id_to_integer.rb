class ChangeCategoryIdToInteger < ActiveRecord::Migration[5.1]
  def change
    change_column :calendar_events, :category_id, :integer

  end
end
