class Loan < ActiveRecord::Base
  has_many :payment_schedules, dependent: :destroy
  has_many :payments, -> { as_of(Date.current) }, through: :payment_schedules

  def payment_schedule
    payment_schedules.as_of(Date.current)
  end
end
