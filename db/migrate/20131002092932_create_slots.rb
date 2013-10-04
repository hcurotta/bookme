class CreateSlots < ActiveRecord::Migration
  def change
    create_table :slots do |t|
      t.integer :availability_id
      t.datetime :starts_at
      t.datetime :ends_at

      t.timestamps
    end
  end
end
