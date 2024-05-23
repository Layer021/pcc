# frozen_string_literal: true

require "google/apis/calendar_v3"
require "googleauth"
require "base64"

class GoogleCalendarService
  def initialize
    scope = Google::Apis::CalendarV3::AUTH_CALENDAR
    credentials_json = Base64.decode64(ENV.fetch("GOOGLE_SERVICE_ACCOUNT_CREDENTIALS", ""))

    authorizer = Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io: StringIO.new(credentials_json),
      scope:
    )

    authorizer.fetch_access_token!
    @client = Google::Apis::CalendarV3::CalendarService.new
    @client.authorization = authorizer
    @calendar_id = ENV.fetch("GOOGLE_CALENDAR_ID", nil)
  end

  def create_event(event_params)
    event = prepare_event_object(event_params)
    @client.insert_event(@calendar_id, event)
  end

  def update_event(event_id, event_params)
    event = prepare_event_object(event_params)
    @client.update_event(@calendar_id, event_id, event)
  end

  def delete_event(event_id)
    @client.delete_event(@calendar_id, event_id)
  end

  private

  def prepare_event_object(event_params)
    Google::Apis::CalendarV3::Event.new(
      summary: event_params[:summary],
      description: event_params[:description],
      start: {
        date_time: event_params[:start_at].rfc3339,
        time_zone: "Asia/Tokyo"
      },
      end: {
        date_time: event_params[:end_at].rfc3339,
        time_zone: "Asia/Tokyo"
      }
    )
  end
end
