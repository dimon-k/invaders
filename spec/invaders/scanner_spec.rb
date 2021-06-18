# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Invaders::Scanner do
  subject(:invaders_scanner) do
    described_class.new(
      invader: invader,
      radar_result: radar_result
    ).call
  end

  let(:invader) do
    [
      '---oo---',
      '--oooo--',
      '-oooooo-',
      'oo-oo-oo',
      'oooooooo',
      '--o--o--',
      '-o-oo-o-',
      'o-o--o-o'
    ].map { |line| line.split('') }
  end
  let(:radar_result) do
    [
      '------o---------------',
      '-o---------oo--------o',
      'o---------ooooo-------',
      '---o-----oo-ooo-------',
      '--------oo-o-ooo------',
      '------o-o-oooooo------',
      '-o--------o--o------o-',
      '--------oo-oo-o--o----',
      '----------oooo-o------',
      '------o----------o----'
    ].map { |line| line.split('') }
  end
  let(:expected_result) do
    [
      '------o---------------',
      "-o------\e[0;31;49mX\e[0m--oo--------o",
      'o---------ooooo-------',
      '---o-----oo-ooo-------',
      '--------oo-o-ooo------',
      '------o-o-oooooo------',
      '-o--------o--o------o-',
      '--------oo-oo-o--o----',
      '----------oooo-o------',
      '------o----------o----'
    ]
  end
  let(:expected_message) do
    "#{'Possible location on the radar marked with'.colorize(:green)} #{'X'.colorize(:red)}#{':'.colorize(:green)}"
  end
  let(:print_location_on_radar) { true }

  before do
    stub_const('Invaders::App::PRINT_LOCATION_ON_RADAR', print_location_on_radar)
    allow($stdout).to receive(:puts)
  end

  it 'returns invader\'s possible location' do
    expect(invaders_scanner).to eq(expected_result)
  end

  context 'with PRINT_LOCATION_ON_RADAR set to true' do
    it 'puts possible location default message' do
      expect($stdout).to receive(:puts).with(expected_message)
      invaders_scanner
    end
  end

  context 'with PRINT_LOCATION_ON_RADAR set to false' do
    let(:print_location_on_radar) { false }

    it 'puts possible location default message' do
      expect($stdout).not_to receive(:puts).with(expected_message)
      invaders_scanner
    end
  end
end
