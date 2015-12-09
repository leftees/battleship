require 'grid.rb'
require 'ship.rb'

class Game
  attr_accessor :command_line
  attr_reader :state, :shots

  STATES = %w(initialized ready error terminated gameover)
  GRID_SIZE = 10  
  NO_SHOT_CHAR = '.'
  MISS_CHAR = '-'
  HIT_CHAR = 'X'

  SHIPS_DEFS = [
    { size: 4 }, # Destroyer
    { size: 4 }, # Destroyer    
    { size: 5 }  # Battleship
  ]

  STATES.each { |state| define_method("#{state}?") { @state==state } }

  def initialize(options = {})
    @state = 'initialized'
    @command_line = nil
    @ships = []
    @shots = 0

    @matrix = Array.new(GRID_SIZE){ Array.new(GRID_SIZE, false) }
    @matrix_oponent = Array.new(GRID_SIZE){ Array.new(GRID_SIZE, NO_SHOT_CHAR) }

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
    end while (not terminated? || ENV['RACK_ENV'] == 'test')
    Grid.message(report)
    self
  end

  def show(options = {})
    # @grid_oponent = Grid.new(@matrix_oponent)
    # @grid_oponent.status_line = "[#{@state}] Wybrałeś: #{ @command_line }"
    # @grid_oponent.show()

    # if options[:debug]
    #   @grid = Grid.new(@matrix)
    #   @grid.status_line = "DEBUG MODE"
    #   @grid.show()
    # end
  end

  # # just some user input validations
  # def << (str)
  #   if not str then return end
  #   @command_line = str.upcase
  # end

  # private

  # def status_line
  #   if initialized? then " " end
  # end

  def add_fleet
    SHIPS_DEFS.each do |ship|
      @fleet << Ship.new(@matrix, ship.size)
    end
  end

  def console
  #   # input = [(print "Enter coordinates (row, col), e.g. A5 (Q to quit): "), gets.rstrip][1]
  #   # self << input
  end


  def report
    if terminated?
      "Terminated by user!"
    else
      "Well done! You completed the game in #{shots} shots"
    end  
  end
end
