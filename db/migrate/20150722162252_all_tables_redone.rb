class AllTablesRedone < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.timestamps
    end

    create_table :spreadsheets do |t|
      t.integer :user_id
      t.string :csv
      t.timestamps
    end
  end
end
