class ChangedExpiredAtToTasks < ActiveRecord::Migration[6.0]
  def change
    change_column :tasks, :expired_at, :datetime, default: -> { 'now()' }, null: false
  end
end
