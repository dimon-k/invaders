# frozen_string_literal: true

module Invaders
  # This class returns amount of invader symbols covered with radar result
  class InvaderDetector
    def initialize(invader:, radar_result:, radar_line_index:, radar_symbol_index:)
      @invader = invader
      @radar_result = radar_result
      @radar_line_index = radar_line_index
      @radar_symbol_index = radar_symbol_index
    end

    def call
      invader_success = 0

      invader.each_with_index do |invader_line, invader_line_index|
        invader_line.each_with_index do |invader_symbol, invader_symbol_index|
          invader_success += 1 if radar_symbol(invader_line_index, invader_symbol_index) == invader_symbol
        end
      end

      invader_success
    end

    private

    attr_reader :invader, :radar_result, :radar_line_index, :radar_symbol_index

    def radar_symbol(invader_line_index, invader_symbol_index)
      radar_result
        .fetch(radar_line_index + invader_line_index, [])
        .fetch(radar_symbol_index + invader_symbol_index, nil)
    end
  end
end
