# frozen_string_literal: true

require "nokogiri"
require "httparty"

class BaseCrawler
  private

  def request(url)
    response = HTTParty.get(url)
    raise "Failed to fetch data from #{url}" unless response.success?

    parse(response.body)
  end

  def parse(html)
    Nokogiri::HTML(html)
  end
end
