class ChangeStatusDefaultValue < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :status, :integer, default: 1
  end

  def down
    change_column :users, :status, :integer
  end
end
