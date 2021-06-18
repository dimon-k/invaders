# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Invaders::Marker do
  subject(:invaders_marker) do
    described_class.new(
      invader_coverage: invader_coverage,
      invader_size: invader_size,
      radar_symbol: radar_symbol,
      radar_line_index: radar_line_index,
      radar_symbol_index: radar_symbol_index
    ).call
  end

  let(:invader_size) { 64 }
  let(:radar_symbol) { 'o' }
  let(:radar_line_index) { 15 }
  let(:radar_symbol_index) { 35 }

  context 'wich high coverage' do
    let(:invader_coverage) { 55 }
    let(:expected_message) do
      'Possible location on line: 12,symbol: 35, with probability: 85.94%'
    end

    it { is_expected.to eq('X'.colorize(:red)) }

    it 'puts invader\'s possible location' do
      expect($stdout).to receive(:puts).with(expected_message)
      invaders_marker
    end
  end

  context 'wich low coverage' do
    let(:invader_coverage) { 45 }

    it { is_expected.to eq('o') }

    it 'doesn\'t put invader\'s possible location' do
      expect($stdout).not_to receive(:puts)
      invaders_marker
    end
  end
end
