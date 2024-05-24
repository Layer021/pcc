# frozen_string_literal: true

class TokyoCameraClubCrawlerWorker
  include Sidekiq::Worker

  def perform
    Rails.logger.info("TokyoCameraClubCrawlerWorker start")
    Crawler::TokyoCameraClubCrawler.new.crawl
    Rails.logger.info("TokyoCameraClubCrawlerWorker end")
  end
end
