# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Invaders do
  it 'has a version number' do
    expect(Invaders::VERSION).not_to be nil
  end

  describe Invaders::App do
    subject(:invaders_app) { described_class.new.call }

    let(:invaders_scanner) { instance_double(Invaders::Scanner, call: true) }
    let(:invader_1_message) { "\e[0;32;49m\nInvader 1:\e[0m" }
    let(:invader_2_message) { "\e[0;32;49m\nInvader 2:\e[0m" }
    let(:invader_1_look) do
      "\e[0;31;49m--o-----o--\n---o---o---\n--ooooooo--\n-oo-ooo-oo-\nooooooooooo\no-ooooooo-o\no-o-----o-o\n---oo-oo---\e[0m"
    end
    let(:invader_2_look) do
      "\e[0;31;49m---oo---\n--oooo--\n-oooooo-\noo-oo-oo\noooooooo\n--o--o--\n-o-oo-o-\no-o--o-o\e[0m"
    end

    before do
      allow(Invaders::Catalog).to receive(:new).and_call_original
      allow(Invaders::Scanner).to receive(:new).and_return(invaders_scanner)
    end

    it 'puts invaders', :aggregate_failures do
      expect($stdout).to receive(:puts).with(invader_1_message)
      expect($stdout).to receive(:puts).with(invader_1_look)
      expect($stdout).to receive(:puts).with(invader_2_message)
      expect($stdout).to receive(:puts).with(invader_2_look)
      invaders_app
    end

    it 'runns the app', :aggregate_failures do
      expect(Invaders::Catalog).to receive(:new).once
      expect(invaders_scanner).to receive(:call).twice
      invaders_app
    end
  end
end
