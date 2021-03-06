Ledger
======

Getting Started
---------------

You will need to install Ruby 2.1.2 to run this app. With RVM, run:

    $ rvm install 2.1.2
    $ rvm use 2.1.2

This repository comes equipped with a self-setup script:

    $ ./bin/setup

After setting up, you can run the application using [foreman]:

    $ foreman start

[foreman]: http://ddollar.github.io/foreman/

Basic Usage
-----------

```ruby
# Seed data
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
        amount_cents: 10000,
      )
    end
  end
end

loan = Loan.first
loan.payment_schedule
loan.payment_schedules.as_of(2.days.ago)
loan.payments
loan.payments.as_of(2.days.ago)
loan.payments.last.previous

# Payments on the same day - previous & next probably won't work
```

Guidelines
----------

Use the following guides for getting things done, programming well, and
programming in style.

* [Protocol](http://github.com/thoughtbot/guides/blob/master/protocol)
* [Best Practices](http://github.com/thoughtbot/guides/blob/master/best-practices)
* [Style](http://github.com/thoughtbot/guides/blob/master/style)
