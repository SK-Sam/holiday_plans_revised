class CreateVacationRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :vacation_requests do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.string :status
      t.references :worker, foreign_key: true

      t.timestamps
    end
  end
end
