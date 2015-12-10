class Ship
  attr_reader :location

  def initialize(matrix, size)
    @xsize = size
    @location = []
    @matrix = matrix
  end

  def build
    begin
      temp = @xsize
      mask = []
      # random start point
      begin
        x = rand(@matrix.size)
        y = rand(@matrix.size)
      end while (@matrix[x][y] === true)
      mask = save_location([x, y])
      temp -= 1
      while(temp > 0 && mask) do
        xy = mask[rand(mask.size)] # random next direction
        mask = save_location(xy)
        temp -= 1
      end
    end while (mask.empty?)
    self
  end

  private

  # returns surrounding mask
  def save_location(coordinates)
    mask = Array.new

    @location << coordinates

    x = coordinates[0]
    y = coordinates[1]
    @matrix[x][y] = true    
    
    mask[0] = [x-1, y  ] if (x-1) >= 0
    mask[1] = [x,   y-1] if (y-1) >= 0
    mask[2] = [x,   y+1] if (y+1) < @matrix.size
    mask[3] = [x+1, y  ] if (x+1) < @matrix.size
    clean(mask)
  end

  def clean(mask)
    mask.select{ |item| not (item .nil? || @matrix[item[0]][item[1]] == true) }
  end
end