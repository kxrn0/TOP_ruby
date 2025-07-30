# frozen_string_literal: true

require_relative '../lib/cipher'

describe '#cipher' do
  it "doesn't change the string with a shift of zero" do
    string = 'Abc...xyZ'
    shift = 0
    result = cipher string, shift

    expect(result).to eql string
  end

  it "It doesn't break with empty strings" do
    string = ''
    shift = 10
    result = cipher string, shift

    expect(result).to eql string
  end

  it 'shift one character forwards' do
    string = 'a'
    shift = 1
    result = cipher string, shift
    expected = 'b'

    expect(result).to eql expected
  end

  it 'shift character backwards' do
    string = 'a'
    shift = -1
    result = cipher string, shift
    expected = 'z'

    expect(result).to eql expected
  end
end
