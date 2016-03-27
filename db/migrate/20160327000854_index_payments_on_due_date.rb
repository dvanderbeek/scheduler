class IndexPaymentsOnDueDate < ActiveRecord::Migration
  def change
    add_index :payments, :due_date
  end
end
