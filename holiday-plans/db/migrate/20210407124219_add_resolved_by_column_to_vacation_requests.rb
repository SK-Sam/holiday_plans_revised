class AddResolvedByColumnToVacationRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :vacation_requests, :resolved_by, :integer
  end
end
