class CreatePaymentSchedules < ActiveRecord::Migration
  def change
    create_table :payment_schedules do |t|
      t.belongs_to :loan, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
