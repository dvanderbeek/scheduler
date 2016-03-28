class Payment < ActiveRecord::Base
  belongs_to :payment_schedule
  has_many :payments, through: :payment_schedule
  has_one :loan, through: :payment_schedule

  default_scope -> { order(due_date: :asc) }

  validates :due_date, :payment_schedule, :amount_cents, :interest_rate, presence: true

  def self.active
    where(payment_schedule: LatestSchedule.pluck(:id))
  end

  def self.after(date)
    where('due_date > ?', date)
  end

  def self.before(date)
    where('due_date < ?', date)
  end

  def self.on_or_after(date)
    where('due_date >= ?', date)
  end

  def self.on_or_before(date)
    where('due_date <= ?', date)
  end

  def self.future(as_of: Date.current, including_today: true)
    including_today ? on_or_after(as_of) : after(as_of)
  end

  def self.next(as_of: Date.current, including_today: true)
    future(as_of: as_of, including_today: including_today).first
  end

  def self.past(as_of: Date.current, including_today: false)
    including_today ? on_or_before(as_of) : before(as_of)
  end

  def self.previous(as_of: Date.current, including_today: false)
    past(as_of: as_of, including_today: including_today).last
  end

  def previous
    payments.previous(as_of: due_date)
  end

  def next
    payments.next(as_of: due_date, including_today: false)
  end
end
