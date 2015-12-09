require "spec_helper"
require "ship"

describe Ship do
  let(:sample_matrix) {  Array.new(10){ Array.new(10, false) }}
  let(:ship) { Ship.new(sample_matrix, 3) }

  it "is valid" do
    expect(ship).to be_kind_of(Ship)
  end

  it "has size" do
    expect(ship.instance_variable_get(:@size)).to eql(3)
  end

  it "has location array" do
    expect(ship.instance_variable_get(:@location)).to be_kind_of(Array)
  end

  it "has matrix array" do
    expect(ship.instance_variable_get(:@matrix)).to eql(sample_matrix)
  end

  it "setup location with random first position" do
    puts ship.location
  end
end
