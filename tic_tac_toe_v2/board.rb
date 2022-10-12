=begin
    The Board class is responsible for adding a player's marks, checking for winners, and printing the game board. 
    A board instance will suport a dynamic board size
=end

class Board
    attr_reader :grid
   
    def initialize(n)
        @grid = Array.new(n) {Array.new(n, "_")}
        @size = n * n
    end

    def [](position)
        #position = [row,column]
        @grid[position[0]][position[1]]
    end

    def []=(position, value)
        @grid[position[0]][position[1]] = value
    end

    def valid?(position)
        #This method should return a boolean indicating whether or not the specified position is valid for the board, 
            #meaning the position is not "out of bounds."
        idx_max = Math.sqrt(@size) - 1
        position.all? {|ele| ele >= 0 && ele <= idx_max}
    end

    def empty?(position)
        #This method should return a boolean indicating whether or not the specified position does not contain a player's mark.
        self[position] == "_"
    end

    def still_space?
        @grid.each do |row|
            row.each {|ele| return true if ele == "_"}
        end
        false
    end

    def place_mark(position, mark)
        return raise "not a valid position...choose again" if !valid?(position)
        return raise "not an empty position...choose again" if !empty?(position)

        self[position] = mark
        puts "Position #{position} has been marked using #{mark}"
        true
    end

    def self.print_grid(grid)
        #print helper method
        grid.each do |row|
            row.each.with_index {|ele, i| print i != row.length-1 ? "#{ele} " : "#{ele}"}
            print "\n"
        end
    end

    def print
        #This method should simply print out the board and all of the marks that have been placed on it
        Board.print_grid(@grid)
    end

    def win_row?(mark)
        n = Math.sqrt(@size)
        @grid.each {|row| return true if row.count(mark) == n} #use any?
        false
    end

    def win_col?(mark)
        n = Math.sqrt(@size)        
        @grid.transpose.each {|row| return true if row.count(mark) == n} #use any?
        false
    end

    def win_diagonal?(mark)
        n = Math.sqrt(@size)
        neg_slope, pos_slope = [], []

        pos = 0
        neg = -1
        
        @grid.each do |row|
            neg_slope << row[pos]
            pos_slope << row[neg]
            pos += 1
            neg -= 1
        end

        neg_slope.count(mark) == n || pos_slope.count(mark) == n
    end

    def win?(mark)
        win_diagonal?(mark) || win_col?(mark) || win_row?(mark)
    end
end

# b = Board.new(6)
# b.print