# frozem_string_literal: true

module Crawler
  class TokyoCameraClubCrawler < BaseCrawler
    def initialize
      super
      @site_url = "https://tokyocameraclub.com/photocontest/open.php"
      @event_key_prefix = "tokyo_camera_club"
      @cal_event_service = CalendarEventService.new
      @gcal_service = GoogleCalendarService.new
    end

    def crawl
      doc = request(@site_url)
      event_list = doc.css("#initiatives .inner").children

      event_list.each do |event|
        # articleタグ以外はスキップ
        next unless event.name == "article"
        save_event(event)
      end
    end

    private

    def save_event(event)
      ActiveRecord::Base.transaction do
        calendar_event = @cal_event_service.save(generate_calendar_event_params(event))
        gcal_event_params = convert_calendar_event_to_gcal_event_params(calendar_event)

        return unless calendar_event.enabled?

        if calendar_event.gcal_event_id.present?
          @gcal_service.update_event(calendar_event.gcal_event_id, gcal_event_params)
        else
          gcal_event = @gcal_service.create_event(gcal_event_params)
          calendar_event.update!(gcal_event_id: gcal_event.id)
        end
      end
    end

    def generate_calendar_event_params(event)
      {
        title: parse_title(event),
        event_key: "#{@event_key_prefix}_#{parse_event_id(event)}",
        end_at: parse_end_at(event),
        url: parse_url(event)
      }
    end

    def parse_title(event)
      event.css("h2").text
    end

    def parse_event_id(event)
      event["id"].gsub("article_", "")
    end

    def parse_end_at(event)
      event_date_text = event.css(".date span").first.text.match(/\d{4}年\d{2}月\d{2}日/).to_s
      event_date_text = Date.strptime(event_date_text, "%Y年%m月%d日").to_s
      event_time_text = event.css(".date").last.text.match(/\d{2}:\d{2}/).to_s
      Time.zone.parse("#{event_date_text} #{event_time_text}")
    end

    def parse_url(event)
      event.css("a").first["href"]
    end

    def convert_calendar_event_to_gcal_event_params(calendar_event)
      {
        summary: calendar_event.title,
        description: "#{calendar_event.description}\n#{calendar_event.url}",
        start_at: calendar_event.start_at,
        end_at: calendar_event.end_at
      }
    end
  end
end
