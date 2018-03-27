# CalendarEvent.create!([
#   {name: "Lunch Date", event_date: "2018-03-31", event_time: "2000-01-01 01:00:00", location: "Quartino's", home: nil, user_id: 1, category: nil},
#   {name: "Coding Class", event_date: "2018-09-03", event_time: "2000-01-01 00:00:00", location: "Northwestern University", home: false, user_id: 1, category: nil},
#   {name: "Manicure ", event_date: "2018-08-15", event_time: "2000-01-01 03:00:00", location: "Digits", home: nil, user_id: 1, category: nil},
#   {name: "Haircut", event_date: "2018-09-02", event_time: "2000-01-01 15:00:00", location: "Fuga Salon & Spa ", home: nil, user_id: 1, category: nil},
#   {name: "Dinner Party", event_date: "2018-10-14", event_time: "2000-01-01 01:00:00", location: "Home", home: true, user_id: 1, category: nil},
#   {name: "Sewing", event_date: "2018-09-09", event_time: "2000-01-01 20:00:00", location: "Home", home: true, user_id: 1, category: nil},
#   {name: "Date Night", event_date: "2018-09-20", event_time: "2000-01-01 02:00:00", location: "Home", home: true, user_id: 1, category: nil},
#   {name: "Pie Eating Contest", event_date: "2018-06-15", event_time: "2000-01-01 03:00:00", location: "Daley Plaza", home: nil, user_id: 1, category: nil},
#   {name: "Read the newspaper ", event_date: "2018-03-04", event_time: "2000-01-01 09:00:00", location: "Home", home: nil, user_id: 1, category: nil},
#   {name: "Dinner ", event_date: "2018-03-10", event_time: "2000-01-01 07:00:00", location: "Spiaggia", home: nil, user_id: 1, category: nil},
#   {name: "Hot Yoga", event_date: "2018-04-04", event_time: "2000-01-01 02:00:00", location: "Cheetah Gym ", home: nil, user_id: 1, category: nil},
#   {name: "Painting with Adam ", event_date: "2018-03-28", event_time: "2000-01-01 02:30:00", location: "Home", home: true, user_id: 1, category: 2},
#   {name: "Guitar Lesson", event_date: "2018-04-02", event_time: "2000-01-01 23:00:00", location: "Home", home: true, user_id: 1, category: 2},
#   {name: "Movie Date", event_date: "2018-04-01", event_time: "2000-01-01 02:00:00", location: "Regal Webster Theatre", home: false, user_id: 1, category: 3},
#   {name: "Make Homemade Ravioli", event_date: "2018-03-15", event_time: "2000-01-01 14:00:00", location: "Home", home: true, user_id: 1, category: 2},
#   {name: "Yoga Class", event_date: "2018-03-30", event_time: "2000-01-01 19:30:00", location: "Cheetah Gym", home: false, user_id: 1, category: 1}
# ])
# User.create!([
#   {name: "Jane", email: "Janedoe@gmail.com", password_digest: "$2a$10$YN2VZljQ6DniIdPC9xERR.dI4HsexVvqZ6bSHVPMCW45sHDHKRDdW", location: "chicago, il"},
#   {name: "Lara", email: "larablapierre@gmail.com", password_digest: "$2a$10$W2fW/9V34gbH/W9ZRpHmqOxp7NyoM4M0aKfwX9M6A8IvsXLgcx3sO", location: nil},
#   {name: "Jerry", email: "jlapier412@gmail.com", password_digest: "$2a$10$0pq6A4BFbpkMB3jxR4GSLe/1jIk7GFSUpQ961WRB4oJCdGkoRrqK2", location: nil}
# ])


events = CalendarEvent.where(event_date: Date.today).order('event_time::time')

time_marker = Time.now
events.each do |event|
  event.update(event_time: time_marker)
  time_marker += 2.minutes
end 


