class User < ApplicationRecord
  has_secure_password 
  has_many :calendar_events
  has_many :categories, through: :calendar_events
  has_one :light
  
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  def weather
    weather_response = Unirest.get("https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22chicago%2C%20il%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys")

    daily_temp = weather_response.body["query"]["results"]["channel"]["item"]["condition"]["temp"]
    daily_cond = weather_response.body["query"]["results"]["channel"]["item"]["condition"]["text"]

    daily_weather = "The current weather for Chicago, IL is #{daily_temp}F and #{daily_cond}."

    return daily_weather
  end 
end
