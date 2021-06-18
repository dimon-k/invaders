# frozen_string_literal: true

require 'colorize'

module Invaders
  # This class marks detected invaders in radar result
  class Marker
    HUNDRED_PERCENT = 100.0
    DEFAULT_PERCENT_THRESHOLD = 75.0

    def initialize(invader_coverage:, invader_size:, radar_symbol:, radar_line_index:, radar_symbol_index:)
      @invader_coverage = invader_coverage
      @invader_size = invader_size
      @radar_symbol = radar_symbol
      @radar_line_index = radar_line_index
      @radar_symbol_index = radar_symbol_index
    end

    def call
      return radar_symbol unless realtive_percentage > DEFAULT_PERCENT_THRESHOLD

      puts possible_location_message

      'X'.colorize(:red)
    end

    private

    attr_reader :invader_coverage, :invader_size, :radar_symbol, :radar_line_index, :radar_symbol_index

    def realtive_percentage
      @realtive_percentage ||= (HUNDRED_PERCENT / invader_size * invader_coverage).round(2)
    end

    def possible_location_message
      "Possible location on line: #{radar_line_index - Invaders::Radar::EXTRA_MARGINS},"\
      "symbol: #{radar_symbol_index}, with probability: #{realtive_percentage}%"
    end
  end
end
