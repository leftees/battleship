require "spec_helper"
require "grid"

describe Grid do
  let(:grid) { Grid.new(Array.new) }

  it "is valid" do
    expect(grid).to be_kind_of(Grid)
  end

  it 'has letters array' do
    expect(Grid::AXE_LETTERS).to eql(%w(A B C D E F G H I J))
  end

  it 'has diggits array' do
    expect(Grid::AXE_DIGGITS).to eql(%w(1 2 3 4 5 6 7 8 9 10))
  end

  it 'has show method' do
    expect(grid).to respond_to(:show)
  end
end
