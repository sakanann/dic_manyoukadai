class AddColumnToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :expired_at, :datetime
  end
end
