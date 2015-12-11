require_relative '../lib/grid.rb'
require_relative '../lib/ship.rb'

class Game
  attr_accessor :command_line
  attr_reader :state, :shots

  STATES = %w(initialized ready error terminated gameover)
  GRID_SIZE = 10
  HIT_CHAR = 'X'
  MISS_CHAR = '-'
  NO_SHOT_CHAR = '.'  

  SHIPS_DEFS = [
    { size: 4}, # Destroyer
    { size: 4 }, # Destroyer    
    { size: 5 }  # Battleship
  ]

  STATES.each { |state| define_method("#{state}?") { @state==state } }

  def initialize(options = {})
    @state = 'initialized'
    @command_line = nil
    @shots = []
    @fleet = []
    @hits_counter = 0
    play
  end

  def play
    begin
      @matrix = Array.new(GRID_SIZE){ Array.new(GRID_SIZE,' ') }
      @matrix_oponent = Array.new(GRID_SIZE){ Array.new(GRID_SIZE, NO_SHOT_CHAR) }
      @grid_oponent = Grid.new

      @state = 'ready'
      add_fleet
      begin
        console      
        case @command_line
        when 'D'
          show(debug: true)
        when 'Q'
          @state = 'terminated'
        when 'I'
          @state = 'initialized'
          @grid_oponent.status_line = "Initialized"
          show
        when /^[A-J]([1-9]|10)$/
          shoot
          report
          show
        else
          @grid_oponent.status_line = "Error: Incorrect input"
          show
          clear_error          
        end
      end while not(gameover? || terminated? || initialized? || ENV['RACK_ENV'] == 'test')
    end while initialized?
    report unless (ENV['RACK_ENV'] == 'test')
    self
  end

  def show(options = {})
    @grid_oponent.build(@matrix_oponent).show()

    if options[:debug]
      @grid = Grid.new.build(@matrix, @fleet)
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
    @fleet = []    
    SHIPS_DEFS.each do |ship_definition|
      ship = Ship.new(@matrix, ship_definition[:size]).build
      @fleet << ship
      @hits_counter += ship_definition[:size] # need for game over check
      for coordinates in ship.location
        @matrix[coordinates[0]][coordinates[1]] = true
      end
    end
  end

  def console
    return nil if ENV['RACK_ENV'] == 'test'
    input = [(print "Enter coordinates (row, col), e.g. A5 (I - initialize, Q to quit): "), gets.rstrip][1]
    self << input
  end

  def shoot
    if xy = convert
      @shots.push(xy)
      @fleet.each do |ship|
        if ship.location.include? xy
          @matrix_oponent[xy[0]][xy[1]] = HIT_CHAR
          @hits_counter -= 1
          @state = 'gameover' if game_over?
          break
        else
          @matrix_oponent[xy[0]][xy[1]] = MISS_CHAR
        end
      end
    end
  end

  def game_over?
    @hits_counter.zero?
  end

  # other way to calculate game_over?
  def fleet_location
    fleet_location = []
    @fleet.each do |ship|
      fleet_location.push(ship.location)
    end
    fleet_location
  end

  def convert
    x = @command_line[0]
    y = @command_line[1..-1]
    [x.ord - 65, y.to_i-1]
  end

  def clear_error
    @state = 'ready'
  end

  def report
    msg = if terminated?
      "Terminated by user after #{@shots.size} shots!"
    elsif gameover?
      "Well done! You completed the game in #{@shots.size} shots"
    else
      "[#{ @state }] Your input: #{ @command_line }"
    end

    Grid.row(msg)
    msg
  end
end
