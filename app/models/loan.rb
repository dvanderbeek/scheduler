class Loan < ActiveRecord::Base
  has_many :payment_schedules
  belongs_to :payment_schedule
  has_many :payments, through: :payment_schedule

  delegate :amount_due_cents, :amount_due_dollars, :interest_rate, to: :payment_schedule
end
