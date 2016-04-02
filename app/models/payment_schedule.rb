class PaymentSchedule < ActiveRecord::Base
  belongs_to :loan
  has_many :payments, dependent: :destroy

  validates :loan, presence: true

  def self.active
    where(id: LatestSchedule.pluck(:id))
  end

  def self.as_of(date)
    where('created_at <= ?', date.end_of_day).order(created_at: :asc).last
  end
end
