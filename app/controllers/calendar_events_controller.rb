class CalendarEventsController < ApplicationController

  def authorize 
    render json: {
                  message: "visit this url",
                  url: "https://api.wink.com/oauth2/authorize?client_id=#{ENV['WINK_CLIENT_ID']}&redirect_uri=http://localhost:3000/wink/callback"
                  }
  end 

  def callback
    render json: {
                  code: params[:code],
                  error: params[:error],
                  state: params[:state]
                  }
  end

  def tokens
    response = Unirest.post("https://api.wink.com/oauth2/token", 
                            headers: {'Content-Type' => 'application/json'},
                            parameters: {"client_secret": ENV['WINK_CLIENT_SECRET'],
                                         "grant_type": "authorization_code",
                                         "code": params[:code]
                                        }
                            
                            )                        
                               
    json_data = response.body
    puts 
    puts "=" * 50 
    puts 
    puts json_data["data"]
    puts 
    puts "=" * 50 
    puts
    
    render json: {
                  access_token: json_data["data"]["access_token"],
                  token_type: json_data["data"]["token_type"],
                  scopes: json_data["data"]["scopes"],
                  expires_in: json_data["data"]["expires_in"],
                  refresh_token: json_data["data"]["refresh_token"]
                  }
  end

  def light_bulb
    response = Unirest.get(
                          "https://api.wink.com/users/me/light_bulbs",
                          headers: {
                                    "Authorization" => "Bearer #{params[:access_token]}"
                                   }

                          )

    json_response = response.body

    render json: {
                   desired_state: json_response["data"][0]["desired_state"]
                 }
  end 
      
  def turn_on
    response = Unirest.put(
                          "https://api.wink.com/light_bulbs/3432100/desired_state",
                            headers: {"Authorization": "Bearer #{ENV['WINK_ACCESS_TOKEN']}", "Content-Type": "application/json"},
                            parameters: {"desired_state": {"powered": true}}
                          )
    json_data = response.body 
    puts "***************"
    p json_data.code
    puts "***************"

    render json: {
                desired_state: json_data["data"]
                 }
  end

  def index 
    @calendar_events = CalendarEvent.all

    

    
    search_term = params[:name]
    if search_term
    end 

    search_date = params[:date]
    if search_date
      @calendar_events = @calendar_events.where("event_date = ?", search_date)
    end 

    search_location = params[:location]
    if search_location
      @calendar_events = @calendar_events.where("location = ?", search_location)
    end 

    search_month = params[:month]
    
    if search_month
     @calendar_events = @calendar_events.where('extract(month from event_date) = ? AND extract(year from event_date) = ?', search_month, 2018)
    end 

    @user = current_user
    render 'index.json.jbuilder'


  end

  def create 
    @calendar_event = CalendarEvent.new(
                                        name: params[:name],
                                        event_date: params[:event_date],
                                        event_time: params[:event_time],
                                        location: params[:location],
                                        home: params[:home],
                                        user_id: current_user.id,
                                        category: params[:category]
                                        # user_location: current_user.location
                                        )
      
      if @calendar_event.save
        render 'show.json.jbuilder'
      else
        render json: {errors: @calendar_event.errors.full_messages}, status: :unprocessable_entity
      end
  end

  def show
    @calendar_event = CalendarEvent.find(params[:id])

    render 'show.json.jbuilder'
  end

  def update
      @calendar_event = CalendarEvent.find(params[:id])
      
      @calendar_event.name = params[:name] || @calendar_event.name
      @calendar_event.event_date = params[:event_date] || @calendar_event.event_date
      @calendar_event.event_time = params[:event_time] || @calendar_event.event_time
      @calendar_event.location = params[:location] || @calendar_event.location
      @calendar_event.home = params[:home] || @calendar_event.home
      @calendar_event.category = params[:category] || @calendar_event.category
    
      if @calendar_event.save
        render 'show.json.jbuilder'
      end
  end

  def destroy
      calendar_event = CalendarEvent.find(params[:id])
      calendar_event.destroy
      render json: {message: "Successfully destroyed calendar_event ##{calendar_event.id}"}
  end

end
