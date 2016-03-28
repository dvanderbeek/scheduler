class CreateLatestSchedules < ActiveRecord::Migration
  def change
    create_view :latest_schedules
  end
end
