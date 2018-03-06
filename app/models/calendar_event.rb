class CalendarEvent < ApplicationRecord
  belongs_to :user 
  enum status: {relaxing: 1, learning: 2, entertaining: 3}


  def pretty_event_time
    event_time.strftime('%e:%M %p ')
  end

  def pretty_event_date
    event_date.strftime("%A, %B %e, %Y ")
  end
end