class CreateAvailabilities < ActiveRecord::Migration
  def change
    create_table :availabilities do |t|
      t.datetime :starts_at
      t.datetime :ends_at
      t.integer  :slot_duration
      t.integer	 :user_id

      t.timestamps
    end
  end
end
