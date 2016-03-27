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
loan = Loan.create

schedule = loan.payment_schedules.create

loan.update(payment_schedule: schedule)

(1..12).each do |n|
  schedule.payments.create({
    due_date: Date.current + n.months,
    amount_cents: 10000,
    interest_rate: 0.15,
  })
end

loan.amount_due_dollars(as_of: 3.months.from_now)
#=> 300.0

loan.interest_rate.to_f
#=> 0.15
```

Guidelines
----------

Use the following guides for getting things done, programming well, and
programming in style.

* [Protocol](http://github.com/thoughtbot/guides/blob/master/protocol)
* [Best Practices](http://github.com/thoughtbot/guides/blob/master/best-practices)
* [Style](http://github.com/thoughtbot/guides/blob/master/style)
