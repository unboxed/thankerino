class AddCompanyIdToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :company_id, :integer, :default => 0
  end

  def self.down
    remove_column :users, :company_id
  end
end
