
json.array! @calendar_events.each do |calendar_event|
  json.user_name calendar_event.user.name
  json.user_location calendar_event.user.location
  json.id calendar_event.id
  json.name calendar_event.name
  json.location calendar_event.location
  json.event_time calendar_event.event_time
  json.event_date calendar_event.event_date
  json.pretty_event_time calendar_event.pretty_event_time
  json.pretty_event_date calendar_event.pretty_event_date
  json.category calendar_event.category
  json.home calendar_event.home
end











 
