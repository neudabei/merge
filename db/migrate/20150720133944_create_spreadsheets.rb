class CreateSpreadsheets < ActiveRecord::Migration
  def change
    create_table :spreadsheets do |t|
      t.integer :user_id
      t.string :csv

      t.timestamps null: false
    end
  end
end
