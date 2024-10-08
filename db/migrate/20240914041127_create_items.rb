class CreateItems < ActiveRecord::Migration[7.2]
  def change
    create_table :items do |t|
      t.string :description
      t.boolean :completed
      t.references :list, null: false, foreign_key: true

      t.timestamps
    end
  end
end
