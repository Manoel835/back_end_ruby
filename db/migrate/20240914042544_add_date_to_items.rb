class AddDateToItems < ActiveRecord::Migration[7.2]
  def change
    add_column :items, :date, :date
  end
end
