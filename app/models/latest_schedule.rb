class LatestSchedule < ActiveRecord::Base
  belongs_to :loan

  default_scope -> { order(created_at: :desc) }

  def payments
    Payment.where(payment_schedule: self.id)
  end
end
