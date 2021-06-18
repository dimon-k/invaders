# frozen_string_literal: true

module Invaders
  # This class returns all known invaders parsed
  class Catalog
    def call
      known_invaders
    end

    private

    def known_invaders
      file_read.map do |file|
        file.split("\n").reject(&:empty?).map do |line|
          line.split('')
        end
      end
    end

    def file_read
      File.read('lib/known_invaders').split('~~~~').reject do |line|
        line.empty? || line == "\n\n"
      end
    end
  end
end
