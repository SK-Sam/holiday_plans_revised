class ChangeVacationRequestStatusToHaveDefaultVals < ActiveRecord::Migration[5.2]
  def change
    change_column :vacation_requests, :status, :string, default: "pending"
  end
end
