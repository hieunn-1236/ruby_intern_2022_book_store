class AddLockableToDevise < ActiveRecord::Migration[6.0]
  def self.up
    add_column :users, :failed_attempts, :integer, default: 0
    add_column :users, :unlock_token, :string
    add_column :users, :locked_at, :datetime
  end
  def self.down
    remove_column :users, :locked_at
    remove_column :users, :unlock_token
    remove_column :users, :failed_attempts
  end
end
