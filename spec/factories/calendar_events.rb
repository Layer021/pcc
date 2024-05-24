FactoryBot.define do
  factory :calendar_event do
    title { |n| "title#{n}" }
    event_key { |n| "event_key#{n}" }
    start_at { Time.zone.now }
    end_at { 1.hour.from_now }
    url { |n| "http://example.com/#{n}" }
    enabled { true }
  end
end
