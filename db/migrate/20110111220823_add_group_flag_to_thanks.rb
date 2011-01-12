class AddGroupFlagToThanks < ActiveRecord::Migration
  def self.up
    add_column :thanks, :group_thanks, :boolean, :default => false
  end

  def self.down
    remove_column :thanks, :group_thanks
  end
end
