# frozen_string_literal: true

module Invaders
  # This class returns list of invaders detected in radar
  class Scanner
    def initialize(invader:, radar_result:)
      @invader = invader
      @radar_result = radar_result
    end

    def call
      result = radar_result.each_with_index.map do |radar_line, radar_line_index|
        radar_line.each_with_index.map do |radar_symbol, radar_symbol_index|
          invaders_marker(
            invader_detector(radar_line_index, radar_symbol_index),
            radar_symbol,
            radar_line_index,
            radar_symbol_index
          )
        end.join
      end

      puts_messages(result) if Invaders::App::PRINT_LOCATION_ON_RADAR

      result
    end

    private

    attr_reader :invader, :radar_result

    def invader_detector(radar_line_index, radar_symbol_index)
      Invaders::InvaderDetector.new(
        invader: invader,
        radar_result: radar_result,
        radar_line_index: radar_line_index,
        radar_symbol_index: radar_symbol_index
      ).call
    end

    def invaders_marker(invader_coverage, radar_symbol, radar_line_index, radar_symbol_index)
      Invaders::Marker.new(
        invader_coverage: invader_coverage,
        invader_size: invader.flatten.size,
        radar_symbol: radar_symbol,
        radar_line_index: radar_line_index,
        radar_symbol_index: radar_symbol_index
      ).call
    end

    def puts_messages(result)
      puts possible_location_message
      puts result
    end

    def possible_location_message
      "#{'Possible location on the radar marked with'.colorize(:green)} #{'X'.colorize(:red)}#{':'.colorize(:green)}"
    end
  end
end
