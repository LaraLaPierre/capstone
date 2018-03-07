class CalendarEventsController < ApplicationController
  def authorize
    render json: {
                  message: "visit this url",
                  url: "https://api.wink.com/oauth2/authorize?client_id=#{ENV['WINK_CLIENT_ID']}&redirect_uri=http://localhost:3000/wink/callback"
                  }
  end 
  


  def index 
    @calendar_events = CalendarEvent.all
    

    search_term = params[:name]
    if search_term
      @calendar_events = @calendar_events.where("name iLike ?", "%#{search_term}%")
    end 

    search_date = params[:date]
    if search_date
      @calendar_events = @calendar_events.where("event_date = ?", search_date)
    end 

    search_location = params[:location]
    if search_location
      @calendar_events = @calendar_events.where("location = ?", search_location)
    end 

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
                                        category_id: params[:category_id],
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
