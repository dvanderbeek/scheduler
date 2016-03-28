SELECT DISTINCT ON (loan_id) *
FROM payment_schedules
ORDER BY loan_id, created_at DESC
