class AddAmountDueCentsToPayments < ActiveRecord::Migration
  def change
    rename_column :payments, :amount_cents, :amount_due_cents
    add_column :payments, :amount_scheduled_cents, :integer
  end
end
