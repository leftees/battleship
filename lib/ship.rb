class Ship
  attr_reader :location

  def initialize(matrix, size)
    @size = size
    @location = []
    @matrix = matrix

    temp = size
    # random start point
    begin
      x = rand(@matrix.size)
      y = rand(@matrix.size)
    end while (@matrix[x][y] === true)
    mask = save_location([x, y])
    temp -= 1
    # while(temp > 0) do
    #   xy = mask[rand(mask.size)]
    #   mask = save_location(xy)
    #   temp -= 1
    # end
  end

  private

  # returns surrounding mask
  def save_location(coordinates)
    mask = Array.new

    @location << coordinates

    x = coordinates[0]
    y = coordinates[1]
    @matrix[x][y] = true    
    
    mask[0] = [x-1, y-1]
    mask[1] = [x-1, y  ]
    mask[2] = [x-1, y+1]
    mask[3] = [x,   y-1]
    mask[4] = [x,   y+1]
    mask[5] = [x+1, y-1]
    mask[6] = [x+1, y]
    mask[7] = [x+1, y+1]
    mask = clean(mask)
    mask.compact!
  end

  def clean(mask)
    ret = mask.map do |item|
      case
      when item[0] < 0
        nil
      when item[1] < 0 
        nil
      when item[0] == @matrix.size
        nil
      when item[1] == @matrix.size
        nil
      when @matrix[item[0]][item[1]]==true
        nil
      else
        item
      end
    end
    ret
  end

end