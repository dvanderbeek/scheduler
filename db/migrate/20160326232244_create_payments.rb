class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.date :due_date
      t.belongs_to :payment_schedule, index: true, foreign_key: true
      t.integer :amount_cents
      t.decimal :interest_rate

      t.timestamps null: false
    end
  end
end
