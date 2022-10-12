require_relative "board"
require_relative "human_player"

=begin
    V2 supports a dynamic board & supports more than two players
=end

class Game
    attr_reader :players, :current_player

    def initialize(n, *players_mark)
        @players = players_mark.map {|mark| HumanPlayer.new(mark)}
        @current_player = @players[0]
        @board = Board.new(n)
    end

    def switch_turn
        @players = @players.rotate
        @current_player =  @players[0]
    end

    def play 
        while @board.still_space?
            @board.print
            position = @current_player.get_position #ex: [0,0]
            output = @board.place_mark(position, @current_player.mark_value)
            return p "Congratulations to Player #{@current_player.mark_value}" if @board.win?(@current_player.mark_value)
            switch_turn
        end
        return p 'Game has ended in a draw...'
    end
end

g = Game.new(6, :A, :B, :C) #change
g.play