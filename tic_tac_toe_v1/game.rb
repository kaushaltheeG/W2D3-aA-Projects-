require_relative "board"
require_relative "human_player"

class Game
    attr_reader :player_1, :player_2, :current_player

    def initialize(player_1_mark, player_2_mark)
        @player_1 = HumanPlayer.new(player_1_mark) 
        @player_2 = HumanPlayer.new(player_2_mark) 
        @current_player = @player_1
        @board = Board.new
    end

    def switch_turn
       @current_player =  @current_player == @player_1 ? @player_2 : @player_1
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

g = Game.new(:X, :O)
g.play