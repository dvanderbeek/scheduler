class Loan < ActiveRecord::Base
  has_many :payment_schedules, dependent: :destroy

  def payment_schedule
    payment_schedules.as_of(Date.current)
  end

  def payments(as_of: Date.current)
    payment_schedules.as_of(as_of).try(:payments)
  end
end
