class Loan < ActiveRecord::Base
  has_many :payment_schedules, dependent: :destroy

  delegate :amount_due_cents, :amount_due_dollars, :interest_rate, to: :payment_schedule

  def payment_schedule(as_of: Date.current)
    payment_schedules.current(as_of: as_of)
  end

  def payments(as_of: Date.current)
    payment_schedule(as_of: as_of).try(:payments)
  end
end
