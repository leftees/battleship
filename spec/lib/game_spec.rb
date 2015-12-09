require "spec_helper"
require "game"

describe Game do
  let(:game) { Game.new }

  before(:each) do
  #   # stub command line loop
  #   Game.instance_variable_set('@command_line', 'Q')
    # expect(Game).to receive(:puts).and_return(nil)
  end

  it "is valid" do
    expect(game).to be_kind_of(Game)
  end

  it "has array of ships" do
    expect(Game::SHIPS).to be_kind_of(Array)
  end

  it "has array of states" do
    expect(Game::SHIPS).to be_kind_of(Array)
  end

  it "has GRID_SIZE" do
    expect(Game::GRID_SIZE).to be_kind_of(Integer)
  end

  describe "#initialize" do
    it "is in initialize state" do
      expect(game).to be_ready
    end

    it "shot to be 0" do
      expect(game.shots).to be_zero
    end

    it "initialize @matrix array" do
      expect(game.instance_variable_get(:@matrix)).to be_kind_of(Array)
    end

    it "initialize @matrix_oponent array" do
      expect(game.instance_variable_get(:@matrix_oponent)).to be_kind_of(Array)
    end

    it "calls #play" do
      expect_any_instance_of(described_class).to receive(:play)
      Game.new
    end
  end

  describe '#play' do
    it "exists" do
      expect(game).to respond_to(:play)
    end

    it "calls #add_fleet" do
      expect(game).to receive(:add_fleet)
      game.play
    end

    it "calls #console" do
      expect(game).to receive(:console)
      game.play
    end

    it "calls #report" do
      expect(game).to receive(:report)
      game.play
    end
  end

  describe '#add_fleet' do
  end

  describe '#show' do
    it "is valid" do
      expect(game).to respond_to(:show)
    end
    
    # it "calls grid's show" do
    #   expect_any_instance_of(Grid).to receive(:show)
    #   game.show
    # end
  end

  describe "#report" do
    it "returns formated text" do
      expect(game.report).to eql('Well done! You completed the game in 0 shots')
    end
  end
end
