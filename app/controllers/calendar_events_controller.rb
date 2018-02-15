class CalendarEventsController < ApplicationController
  
  def index 
    @calendar_events = CalendarEvent.all
    render 'index.json.jbuilder'
  end

  def create 
    @calendar_event = CalenderEvent.new(
                                        name: params[:name],
                                        event_date: params[:event_date],
                                        event_time: params[:event_time],
                                        location: params[:location],
                                        home: params[:home]
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
