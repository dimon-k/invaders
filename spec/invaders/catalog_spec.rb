# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Invaders::Catalog do
  subject { described_class.new.call }

  let(:expected_result) do
    [
      [
        %w[- - o - - - - - o - -],
        %w[- - - o - - - o - - -],
        %w[- - o o o o o o o - -],
        %w[- o o - o o o - o o -],
        %w[o o o o o o o o o o o],
        %w[o - o o o o o o o - o],
        %w[o - o - - - - - o - o],
        %w[- - - o o - o o - - -]
      ],
      [
        %w[- - - o o - - -],
        %w[- - o o o o - -],
        %w[- o o o o o o -],
        %w[o o - o o - o o],
        %w[o o o o o o o o],
        %w[- - o - - o - -],
        %w[- o - o o - o -],
        %w[o - o - - o - o]
      ]
    ]
  end

  it 'returns all known invader as nested arrays' do
    expect(subject).to eq(expected_result)
  end
end
