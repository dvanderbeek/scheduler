class LatestSchedule < ActiveRecord::Base
  self.primary_key = :id

  belongs_to :loan
  has_many :payments, foreign_key: :payment_schedule_id
end
