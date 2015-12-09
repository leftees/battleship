class Grid
  attr_accessor :status_line

  AXE_LETTERS = %w( A B C D E F G H I J )
  AXE_DIGGITS = %w( 1 2 3 4 5 6 7 8 9 10 )

  def initialize(matrix)
    @matrix = matrix
  end

  def show
    # puts "=" * AXE_DIGGITS.size*2
    # puts status_line
    # puts "  #{AXE_DIGGITS.join(' ')}"
    # @matrix.each_with_index do |row, index|
    #   puts "#{AXE_LETTERS[index]} #{row.join(' ')}"
    # end
  end

  def self.message(txt)
    # puts txt if txt
  end
end
