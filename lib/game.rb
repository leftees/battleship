require_relative '../lib/grid.rb'
require_relative '../lib/ship.rb'

class Game
  attr_accessor :command_line
  attr_reader :state, :shots, :fleet

  STATES = %w(initialized ready error terminated gameover)
  GRID_SIZE = 10  

  SHIPS_DEFS = [
    { size: 4 }, # Destroyer
    { size: 4 }, # Destroyer    
    { size: 5 }  # Battleship
  ]

  STATES.each { |state| define_method("#{state}?") { @state==state } }

  def initialize(options = {})
    @state = 'initialized'
    @command_line = nil
    @fleet = []
    @shots = []

    @matrix = Array.new(GRID_SIZE){ Array.new(GRID_SIZE, false) }
    @matrix_oponent = Array.new(GRID_SIZE){ Array.new(GRID_SIZE, false) }

    play
  end

  def play
    @state = 'ready'
    add_fleet
    begin
      console      
      case @command_line
      when 'S'
        show(debug: true)
      when 'Q'
        @state = 'terminated'
      else
        show
      end
    end while not(terminated? || ENV['RACK_ENV'] == 'test')
    Grid.row(report)
    self
  end

  def show(options = {})
    grid_oponent = Grid.new(@matrix_oponent)
    grid_oponent.status_line = "[#{@state}] Wybrałeś: #{ @command_line }"
    grid_oponent.show()

    if options[:debug]
      @grid = Grid.new(@matrix, @fleet)
      @grid.status_line = "DEBUG MODE"
      @grid.show
    end
  end

  # just some user input validations
  def << (str)
    if not str then return end
    @command_line = str.upcase
  end

  private

  def status_line
    if initialized? then " " end
  end

  def add_fleet
    SHIPS_DEFS.each do |ship|
      @fleet << Ship.new(@matrix, ship[:size]).build
    end
  end

  def console
    if ENV['RACK_ENV'] != 'test'
      input = [(print "Enter coordinates (row, col), e.g. A5 (Q to quit): "), gets.rstrip][1]
      self << input
    end
  end

  def report
    if terminated?
      "Terminated by user after #{@shots.size} shots!"
    else
      "Well done! You completed the game in #{@shots.size} shots"
    end  
  end
end
