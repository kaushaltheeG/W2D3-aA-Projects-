require_relative "./board.rb"

class HumanPlayer
    attr_reader :mark_value

    def initialize(mark_value)
        @mark_value = mark_value
    end

    def get_position(legal_positions)
        valid_input, msg = false, ''
        while !valid_input
            puts "Player #{@mark_value}, please enter two numbers with a space in between them"
            player_input = gets.chomp.split(' ')
            
            raise ArgumentError.new "improper input amount...please enter two numbers with one space in between" if !improper_count(player_input) #raise breaks out of the function like return
            
            position = []
            player_input.each do |input|
                raise ArgumentError.new "did not enter a number...please enter two numbers with one space in between" if not_aNum(input)
                position << input.to_i
            end

            p "Cannot place at #{position} , please choose again" if !legal_positions.include?(position)
            valid_input = true if legal_positions.include?(position)
        end
        position
    end

    def not_aNum(user_input)
        alpha = ('a'..'z').to_a + ('A'.."Z").to_a
        alpha.include?(user_input)
    end

    def improper_count(arr_pos)
        arr_pos.length == 2
    end
end