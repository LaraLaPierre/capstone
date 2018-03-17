require 'rufus-scheduler'
require 'unirest'

# scheduler = Rufus::Scheduler.new

# scheduler.every("10s") do  


#   response = Unirest.put(
#                           "https://api.wink.com/light_bulbs/3432100/desired_state",
#                             headers: {"Authorization": "Bearer #{ENV['WINK_ACCESS_TOKEN']}", "Content-Type": "application/json"},
#                             parameters: {"desired_state": {"powered": true}}
#                           )

#     json_data = response.body 
#     puts "***************"
#     p json_data.code
#     puts "***************"

#     render json: {
#                 desired_state: json_data["data"]
#               }


# end


