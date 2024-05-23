# frozen_string_literal: true

class CalendarEventService
  def save(calendar_event_params)
    calendar_event = CalendarEvent.find_or_initialize_by(event_key: calendar_event_params[:event_key])
    calendar_event.assign_attributes(calendar_event_params)
    calendar_event.start_at = Time.zone.today if calendar_event.start_at.blank?
    calendar_event.save!
    calendar_event
  end
end
