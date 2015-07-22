class RemoveColumnFromUsers2 < ActiveRecord::Migration
  def change
    remove_column(:users, :csv)
  end
end
