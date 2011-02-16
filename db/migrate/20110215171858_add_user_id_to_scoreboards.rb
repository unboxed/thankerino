class AddUserIdToScoreboards < ActiveRecord::Migration
  def self.up
    add_column :scoreboards, :user_id, :integer
  end

  def self.down
    remove_column :scoreboards, :user_id
  end
end
