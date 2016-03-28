class RemovePaymentScheduleIdFromLoans < ActiveRecord::Migration
  def change
    remove_column :loans, :payment_schedule_id, :integer, index: true
  end
end
