class ComputerPlayer
    attr_reader :mark_value

    def initialize(mark_value)
        @mark_value = mark_value
    end

    def get_position(legal_positions)
        idx = rand(0...legal_positions.length) 
        pos = legal_positions.slice(idx)
        puts "Computer has choosen #{pos}"
        pos
    end

    def not_aNum(user_input)
        alpha = ('a'..'z').to_a + ('A'.."Z").to_a
        alpha.include?(user_input)
    end

    def improper_count(arr_pos)
        arr_pos.length == 2
    end
end

# com = ComputerPlayer.new(:X)
# p com.get_position([[1,0],[2,0],[3,0]])