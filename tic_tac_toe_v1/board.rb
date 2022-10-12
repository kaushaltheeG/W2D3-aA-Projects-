=begin
    The Board class is responsible for adding a player's marks, checking for winners, and printing the game board. 
    A board instance must have an attribute to represent the grid. For simplicity, give the grid the dimensions of classic tic-tac-toe, 3x3.
=end

class Board
    attr_reader :grid

    def initialize
        @grid = Array.new(3) {Array.new(3, "_")}
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
        position.all? {|ele| ele >= 0 && ele <= 2}
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
        @grid.each {|row| return true if row.count(mark) == 3}
        false
    end

    def win_col?(mark)
        temp_grid = Array.new(3) {Array.new(3, "_")}

        @grid.each.with_index do |row, i|
            row.each.with_index { |ele, k| temp_grid[i][k] = ele if ele != "_" }
        end
        
        temp_grid.transpose.each {|row| return true if row.count(mark) == 3}
        false
    end

    def win_diagonal?(mark)
        neg_slope, pos_slope = [], []

        pos = 0
        neg = -1
        
        @grid.each do |row|
            neg_slope << row[pos]
            pos_slope << row[neg]
            pos += 1
            neg -= 1
        end
        # p neg_slope.uniq
        # p pos_slope.uniq
        # (neg_slope.uniq.length == 1 || pos_slope.uniq.length == 1) && (neg_slope.uniq)
        neg_slope.count(mark) == 3 || pos_slope.count(mark) == 3
    end

    def win?(mark)
        win_diagonal?(mark) #|| win_col?(mark) || win_row?(mark)
    end
end