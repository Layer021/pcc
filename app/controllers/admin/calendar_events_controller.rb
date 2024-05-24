class Admin::CalendarEventsController < Admin::ApplicationController
  def index
    @calendar_events = CalendarEvent.order(id: :desc)
  end

  def update
    calendar_event = CalendarEvent.find(params[:id])

    calendar_event.transaction do
      calendar_event.update!(calendar_event_params)

      if calendar_event.enabled?
        create_gcal_event(calendar_event)
      else
        delete_gcal_event(calendar_event)
      end
    end

    redirect_to calendar_events_path
  end

  private

  def calendar_event_params
    params.require(:calendar_event).permit(:enabled)
  end

  def delete_gcal_event(calendar_event)
    GoogleCalendarService.new.delete_event(calendar_event.gcal_event_id)
    calendar_event.update!(gcal_event_id: nil)
  end

  def create_gcal_event(calendar_event)
    gcal_event_params = {
      summary: calendar_event.title,
      description: "#{calendar_event.description}\n#{calendar_event.url}",
      start_at: calendar_event.start_at,
      end_at: calendar_event.end_at
    }
    gcal_event = GoogleCalendarService.new.create_event(gcal_event_params)
    calendar_event.update!(gcal_event_id: gcal_event.id)
  end
end
