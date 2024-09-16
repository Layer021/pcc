class Api::CalendarEventsController < Api::ApplicationController
  def index
    @calendar_events = CalendarEvent.all
  end

  def show
    @calendar_event = CalendarEvent.find(params[:id])
  end
end
