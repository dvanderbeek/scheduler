class RenameDueDate < ActiveRecord::Migration
  def change
    rename_column :payments, :due_date, :date
  end
end
