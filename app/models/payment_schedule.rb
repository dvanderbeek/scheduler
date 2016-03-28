class PaymentSchedule < ActiveRecord::Base
  belongs_to :loan
  has_many :payments, dependent: :destroy

  validates :loan, presence: true

  def self.active
    # TODO: Should probably select max created_at
    where("payment_schedules.id IN (SELECT MAX(payment_schedules.id) FROM payment_schedules GROUP BY loan_id)")
  end

  def self.current(as_of: Date.current)
    where('created_at <= ?', as_of.end_of_day).order(created_at: :asc).last
  end

  def amount_due_cents(as_of: Date.current)
    payments.past(as_of: as_of, including_today: true).sum(:amount_cents)
  end

  def amount_due_dollars(as_of: Date.current)
    amount_due_cents(as_of: as_of).to_f / 100
  end

  def interest_rate(as_of: Date.current)
    payments.next(as_of: as_of).try(:interest_rate)
  end
end
