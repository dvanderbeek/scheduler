class LatestSchedule < ActiveRecord::Base
  belongs_to :loan
  has_many :payments, foreign_key: :payment_schedule_id

  self.primary_key = :id
end
