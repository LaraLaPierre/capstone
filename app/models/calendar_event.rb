class CalendarEvent < ApplicationRecord
  belongs_to :user 
  enum status: {entertaining: 1, relaxing: 2, learning: 3}

  def pretty_event_time
    event_time.strftime("%l:%M %p ")
  end

  def pretty_event_date
    event_date.strftime("%A, %B %e, %Y ") 
  end

  def forecast    
    if event_date <= 10.days.from_now
      weather_response = Unirest.get("https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22chicago%2C%20il%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys")

      forecast_dates = weather_response.body["query"]["results"]["channel"]["item"]["forecast"]

      forecast_data = forecast_dates.select { |forecast|  event_date == Date.parse(forecast["date"]) }.first

      if forecast_data == nil
        forecast_for_event = "Weather forecast is not available at this time"
      else
        forecast_for_event = "The forecast for #{event_date.strftime("%A, %B %e, %Y")} is a high of #{forecast_data["high"]}F and a low of #{forecast_data["low"]}F with #{forecast_data["text"]} conditions."
      end
    else
      forecast_for_event = "Weather forecast is not available at this time"
    end

    forecast_for_event
  end

end