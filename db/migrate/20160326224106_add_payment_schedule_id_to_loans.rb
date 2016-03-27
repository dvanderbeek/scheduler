class AddPaymentScheduleIdToLoans < ActiveRecord::Migration
  def change
    add_column :loans, :payment_schedule_id, :integer, index: true, foreign_key: true
  end
end
