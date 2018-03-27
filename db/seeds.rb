

events = CalendarEvent.where(event_date: Date.today).order('event_time::time')

time_marker = Time.now
events.each do |event|
  event.update(event_time: time_marker)
  time_marker += 2.minutes
end 


