class RemoveInterestRateFromPayments < ActiveRecord::Migration
  def change
    remove_column :payments, :interest_rate, :decimal
  end
end
