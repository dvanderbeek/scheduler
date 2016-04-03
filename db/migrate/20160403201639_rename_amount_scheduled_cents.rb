class RenameAmountScheduledCents < ActiveRecord::Migration
  def change
    rename_column :payments, :amount_scheduled_cents, :amount_cents
  end
end
