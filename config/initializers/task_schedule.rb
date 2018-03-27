require 'rufus-scheduler'
require 'unirest' 
require 'date'
require 'time'

scheduler = Rufus::Scheduler.new

scheduler.every("30s") do  

  response = Unirest.get("http://localhost:3000/calendar_events")
  
  response.body.each do |event|
    if Date.parse(event["event_date"]) == Date.today
      time = Time.now
      time_2 = time + 60
      test_time = Time.parse(event["event_time"]) 
      time = time.strftime("%H:%M")
      time_2 = time_2.strftime("%H:%M")
      test_time = test_time.strftime("%H:%M")
      allowed_ranges = ["#{time}".."#{time_2}"]
    
      in_range = allowed_ranges.any? { |range| range.cover?(test_time) }
      if in_range 
        if event["category"] == 1
          brightness = 1.0
        elsif event["category"] == 2
          brightness = 0.1
        elsif event["category"] == 3
          brightness = 0.6
        end 

        response = Unirest.put(
                              "https://api.wink.com/light_bulbs/3432100/desired_state",
                                headers: {"Authorization": "Bearer #{ENV['WINK_ACCESS_TOKEN']}", "Content-Type": "application/json"},
                                parameters: {"desired_state": {"powered": event["home"], "brightness": brightness}}
                              )
      end
    end
  end  
end



