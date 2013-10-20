class CreateRecurrences < ActiveRecord::Migration
  def change
    create_table :recurs do |t|
      t.datetime :ends_at
      t.string :every
      t.integer :availability_id

      t.timestamps
    end
  end
end
