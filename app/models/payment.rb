class Payment < ActiveRecord::Base
  include ActsAsTimeline
  acts_as_timeline :due_date

  belongs_to :payment_schedule
  has_many :payments, through: :payment_schedule
  has_one :loan, through: :payment_schedule

  default_scope -> { order(due_date: :asc) }

  def self.active
    where(payment_schedule_id: Loan.pluck(:payment_schedule_id))
  end
end
