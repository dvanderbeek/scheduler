Loan.create do |loan|
  loan.payment_schedules.build do |payment_schedule|
    payment_schedule.created_at = 2.days.ago
    payment_schedule.updated_at = 2.days.ago
    (1..12).each do |n|
      payment_schedule.payments.build(
        due_date: 2.days.ago + n.months,
        amount_cents: 10000,
      )
    end
  end

  loan.payment_schedules.build do |payment_schedule|
    (1..12).each do |n|
      payment_schedule.payments.build(
        due_date: Date.current + n.months,
        amount_cents: 50000,
      )
    end
  end
end