class Player
    def get_move
        print "enter a position with coordinates separated with a space like `4 7`"
        move = gets.chomp
        move_arr = move.split(' ')
        #move_arr.map {|num| num.to_i}
        move_arr.map(&:to_i) #better
    end
end
