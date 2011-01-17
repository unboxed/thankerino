class CreateScoreboards < ActiveRecord::Migration
  def self.up
    create_table :scoreboards do |t|
      t.string :name
      t.date :from_date
      t.date :to_date
      t.timestamps
    end
  end

  def self.down
    drop_table :scoreboards
  end
end
