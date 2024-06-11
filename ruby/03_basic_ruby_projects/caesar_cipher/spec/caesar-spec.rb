require "./lib/main.rb"

describe "#cipher" do
  it "doesn't change the string with a shift of zero" do
    string = "But i've been trying to break the cycle."
    shift = 0
    result = cipher string, shift
    
    expect(result).to eql string
  end

  it "It doesn't break with empty strings" do
    string = ""
    shift = 10
    result = cipher string, shift

    expect(result).to eql string
  end

  it "shift one character forwards" do
    string = "a"
    shift = 1
    result = cipher string, shift
    expected = "b"

    expect(result).to eql expected
  end

  it "shift character backwards" do
    string = "a"
    shift = -1
    result = cipher string, shift
    expected = "z"

    expect(result).to eql expected
  end

  it "encode string" do
    string = "But i've been trying to break the cycle."
    shift = 3
    result = cipher string, shift
    expected = "Exw l'yh ehhq wublqj wr euhdn wkh fbfoh."

    expect(result).to eql expected   
  end
end