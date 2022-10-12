class Board
    attr_reader :size

    def initialize(n)
        @grid = Array.new(n) {Array.new(n, :N)}
        @size = n * n
    end

    def [](position)
        #position = [row,column]
        @grid[position[0]][position[1]]
    end

    def []=(position, value)
        @grid[position[0]][position[1]] = value
    end

    def num_ships
        count = 0
        @grid.each {|row| count += row.count(:S)}
        count 
    end

    def attack(position)    
        if self[position] == :S
            self[position] = :H
            puts 'you sunk my battleship!'
            return true
        else
            self[position] = :X
            return false
        end
    end

    def place_random_ships
        n = Math.sqrt(@size).to_i
        num_of_ships = @size / 4

        until num_of_ships == 0 do 
            random_position = [rand(0...n), rand(0...n)]
            if self[random_position] != :S
                self[random_position] = :S
                num_of_ships -= 1
            end
        end
    end

    def hidden_ships_grid
        n = Math.sqrt(@size).to_i
        hidden_grid = Array.new(n) {Array.new(n, :N)}
        
        @grid.each.with_index do |row, ri|
            row.each.with_index {|ele, ci| hidden_grid[ri][ci] = :X if ele == :X}
        end

        hidden_grid
    end

    def self.print_grid(grid)
        grid.each do |row| 
            row.each.with_index do |ele, i| 
                print i != row.length-1 ? "#{ele} " : "#{ele}"
            end
            puts '' # or print "\n"
        end
    end

    def cheat
        Board.print_grid(@grid)
    end

    def print
        Board.print_grid(hidden_ships_grid)
    end
end
