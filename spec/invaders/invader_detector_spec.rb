# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Invaders::InvaderDetector do
  subject do
    described_class.new(
      invader: invader,
      radar_result: radar_result,
      radar_line_index: radar_line_index,
      radar_symbol_index: radar_symbol_index
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
  let(:radar_line_index) { 1 }
  let(:radar_symbol_index) { 8 }

  context 'wich high coverage' do
    let(:radar_line_index) { 1 }
    let(:radar_symbol_index) { 8 }

    it { is_expected.to eq(55) }
  end

  context 'wich low coverage' do
    let(:radar_line_index) { 0 }
    let(:radar_symbol_index) { 0 }

    it { is_expected.to eq(26) }
  end
end
