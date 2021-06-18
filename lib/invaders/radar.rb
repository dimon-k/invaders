# frozen_string_literal: true

module Invaders
  # This class returns radar result parsed
  class Radar
    EXTRA_MARGINS = 3

    def call
      radar_result
        .prepend(margin)
        .append(margin)
        .flatten
        .map! { |z| z.split('') }
    end

    private

    def radar_result
      file_read.map do |file|
        file.split("\n").reject(&:empty?)
      end.last
    end

    def file_read
      File.read('lib/radar_result').split('~~~~').reject do |line|
        line.empty? || line == "\n\n"
      end
    end

    def margin
      @margin ||= EXTRA_MARGINS.times.map { '-' * 100 }
    end
  end
end
