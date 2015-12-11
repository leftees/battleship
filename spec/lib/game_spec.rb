require "spec_helper"
require "game"

describe Game do
  let(:game) { Game.new }

  it "is valid" do
    expect(game).to be_kind_of(Game)
  end

  it "has array of ships" do
    expect(Game::SHIPS_DEFS).to be_kind_of(Array)
    expect(Game::SHIPS_DEFS).to_not be_empty    
  end

  it "has array of states" do
    expect(Game::STATES).to be_kind_of(Array)
  end

  it "has GRID_SIZE" do
    expect(Game::GRID_SIZE).to be_kind_of(Integer)
  end

  describe "#initialize" do
    it "leads to 'ready' state" do
      expect(game).to be_ready
    end

    it "shots size should be 0" do
      expect(game.shots.size).to be_zero
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

    describe "makes fleet" do
      it "array" do
        expect(game.instance_variable_get(:@fleet)).to be_kind_of(Array)
      end

      it "with correct size" do
        expect(game.instance_variable_get(:@fleet).size).to eql(Game::SHIPS_DEFS.size)
      end

      it "with correct type" do
        expect(game.instance_variable_get(:@fleet)[0]).to be_kind_of(Ship)
      end      
    end
  end

  describe "#clear_error" do
    it "cleans error status" do
      game.instance_variable_set("@state","error")
      expect{game.send(:clear_error)}.to change{
        game.instance_variable_get(:@state)
      }.from('error').to('ready')
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

    describe "with console" do
      it "when 'Q'" do
        game.instance_variable_set("@command_line","Q")
        expect{game.play}.to change{ game.state }.from('ready').to('terminated')
      end

      it "when 'D'" do
        game.instance_variable_set("@command_line","D")
        expect(game).to receive(:show).with( debug: true )
        game.play
      end

      describe "when 'A5'" do
        before(:each) { game.instance_variable_set("@command_line","A5") }

        it "calls #shoot" do
          expect(game).to receive(:shoot)
          game.play
        end

        it "calls #report" do
          expect(game).to receive(:report)
          game.play
        end

        it "calls #show" do
          expect(game).to receive(:show)
          game.play
        end
      end
    end
  end

  describe '#show' do
    it "is valid" do
      expect(game).to respond_to(:show)
    end
  end

  describe "#fleet_location" do
    it "is valid" do

      matrix = Array.new(4){ Array.new(4, ' ') }

      ship1 = Ship.new(matrix, 1).build
      ship1.instance_variable_set("@location", [1,0]) 

      ship2 = Ship.new(matrix, 1).build
      ship2.instance_variable_set("@location", [3,2]) 

      fleet = [ship1, ship2]
      game.instance_variable_set("@fleet", fleet)

      expect(game.send(:fleet_location)).to eql [ [1, 0], [3, 2] ]
    end
  end

  describe '#convert' do
    it "converts from A5 to coordinates" do
      game.command_line = "B5"
      expect(game.send(:convert)).to eql([1, 4])
    end
  end

  describe '#game_over?' do
    it "it returns true when hits_counter is zero" do
      game.instance_variable_set("@hits_counter", 0)
      expect(game.send(:game_over?)).to be_truthy
    end

    it "it returns false when hits_counter is not zero" do
      expect(game.send(:game_over?)).to be_falsy      
    end
  end

  describe "#report" do
    it "returns text" do
      expect(game.send(:report)).to eql "[ready] Your input: "
    end
  end
end
