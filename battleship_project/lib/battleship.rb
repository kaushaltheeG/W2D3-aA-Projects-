require_relative "board"
require_relative "player"

class Battleship
    attr_reader :board, :player

    def initialize(n)
        n = n.to_i
        @player = Player.new
        @board = Board.new(n)
        @remaining_misses = @board.size / 2
    end

    def start_game
        @board.place_random_ships
        puts "Numer of ships on the board is #{@board.num_ships}"
        @board.print
    end

    def lose?
        puts 'you lose' if @remaining_misses <= 0
        @remaining_misses <= 0 ? true : false
    end

    def win?
        puts 'you win' if @board.num_ships == 0
        @board.num_ships == 0 ? true : false
    end

    def game_over?
        self.win? || self.lose? ? true : false
    end

    def turn 
        move = @player.get_move #arr [x, y]
        result = @board.attack(move) #bool result
        
        @remaining_misses -= 1 if !result
        @board.print
        puts "You have #{@remaining_misses} remaining misses"
    end

end
