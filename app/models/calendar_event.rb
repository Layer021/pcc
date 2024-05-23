class CalendarEvent < ApplicationRecord
  validates :title, presence: true
  validates :event_key, presence: true, uniqueness: true
  validates :start_at, presence: true
  validates :end_at, presence: true
end
