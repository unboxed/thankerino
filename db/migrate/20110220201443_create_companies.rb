class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.string :name
      t.boolean :is_public, :default => 1

      t.timestamps
    end
  end

  def self.down
    drop_table :companies
  end
end
