class CreateWorkers < ActiveRecord::Migration[5.2]
  def change
    create_table :workers do |t|
      t.integer :vacation_days_remaining
      t.integer :requests_remaining
      t.references :manager, foreign_key: true

      t.timestamps
    end
  end
end
