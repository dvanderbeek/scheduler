module ActsAsTimeline
  extend ActiveSupport::Concern

  def previous
    payments.previous(as_of: public_send(self.timeline_date_field))
  end

  def next
    payments.next(as_of: public_send(self.timeline_date_field), including_today: false)
  end

  module ClassMethods
    def acts_as_timeline(field)
      cattr_accessor :timeline_date_field
      self.timeline_date_field = field
    end

    def after(date = Date.current)
      where("#{self.timeline_date_field} > ?", date)
    end

    def before(date = Date.current)
      where("#{self.timeline_date_field} < ?", date)
    end

    def on_or_after(date = Date.current)
      where("#{self.timeline_date_field} >= ?", date)
    end

    def on_or_before(date = Date.current)
      where("#{self.timeline_date_field} <= ?", date)
    end

    def future(as_of: Date.current, including_today: true)
      including_today ? on_or_after(as_of) : after(as_of)
    end

    def next(as_of: Date.current, including_today: true)
      future(as_of: as_of, including_today: including_today).first
    end

    def past(as_of: Date.current, including_today: false)
      including_today ? on_or_before(as_of) : before(as_of)
    end

    def previous(as_of: Date.current, including_today: false)
      past(as_of: as_of, including_today: including_today).last
    end
  end
end
