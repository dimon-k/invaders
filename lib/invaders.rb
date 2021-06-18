# frozen_string_literal: true

require 'pry'

Dir['./lib/invaders/*.rb'].sort.each { |file| require file }

module Invaders
  # This is the main App class
  class App
    # If 'true', will print on the radar example possible locations
    # with 'X' sign indicating top left corner of detected invaders
    PRINT_LOCATION_ON_RADAR = true

    def call
      Invaders::Catalog.new.call.each.with_index(1) do |invader, invader_index|
        puts "\nInvader #{invader_index}:".colorize(:green)
        puts invader.map(&:join).join("\n").colorize(:red)

        Invaders::Scanner.new(
          invader: invader,
          radar_result: Invaders::Radar.new.call
        ).call
      end

      true
    end
  end

  Invaders::App.new.call
end
