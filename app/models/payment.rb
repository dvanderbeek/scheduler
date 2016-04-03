class Payment < ActiveRecord::Base
  belongs_to :payment_schedule
  has_many :payments, through: :payment_schedule
  has_one :loan, through: :payment_schedule

  default_scope -> { order(date: :asc) }

  before_validation :set_defaults, on: :create

  validates :date, :payment_schedule, :amount_due_cents, :amount_cents, presence: true

  def self.active
    where(payment_schedule: LatestSchedule.pluck(:id))
  end

  def self.as_of(date)
    unscope(where: :payment_schedule_id).
      where(payment_schedule: PaymentSchedule.as_of(date))
  end

  def self.after(date)
    where('date > ?', date)
  end

  def self.before(date)
    where('date < ?', date)
  end

  def self.on_or_after(date)
    where('date >= ?', date)
  end

  def self.on_or_before(date)
    where('date <= ?', date)
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
    payments.previous(as_of: date)
  end

  def next
    payments.next(as_of: date, including_today: false)
  end

  private

  def set_defaults
    self.amount_due_cents ||= self.amount_cents
  end
end
