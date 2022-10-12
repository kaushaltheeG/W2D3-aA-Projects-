require_relative "board"
require_relative "human_player"
require_relative "computer_player"

=begin
    V3 implement a simple ComputerPlayer class that will play randomly. Also added some improved error handling for our existing HumanPlayers.
=end

class Game
    attr_reader :players, :current_player

    def initialize(n, *players_mark)
        @players = [] #array is filled with the code below
        players_mark.pop.each {|mark, val| @players.push(!val ? HumanPlayer.new(mark) : ComputerPlayer.new(mark))}
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
            valid_positions = @board.legal_positions
            position = @current_player.get_position(valid_positions)
            output = @board.place_mark(position, @current_player.mark_value)
            return p "Congratulations to Player #{@current_player.mark_value}" if @board.win?(@current_player.mark_value)
            switch_turn
        end
        return p 'Game has ended in a draw...'
    end

end

machine_civil_war = Game.new(10, h: false, u: false, e: false)
machine_civil_war.play
