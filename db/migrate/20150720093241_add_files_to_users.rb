class AddFilesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :files, :json
  end
end
