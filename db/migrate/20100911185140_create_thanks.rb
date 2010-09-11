class CreateThanks < ActiveRecord::Migration
  def self.up
    create_table :thanks do |t|
      t.string :message, :null => false
      t.integer :from_user
      t.integer :to_user

      t.timestamps
    end
  end

  def self.down
    drop_table :thanks
  end
end
