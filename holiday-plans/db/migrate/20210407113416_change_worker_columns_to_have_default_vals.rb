class ChangeWorkerColumnsToHaveDefaultVals < ActiveRecord::Migration[5.2]
  def change
    change_column :workers, :vacation_days_remaining, :integer, default: 28
    change_column :workers, :requests_remaining, :integer, default: 30
  end
end
