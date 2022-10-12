require_relative "code"

class Mastermind
    def initialize(length)
        @secret_code = Code.random(length)
    end

    def print_matches(code_inst)
        puts "Secret Code vs Arg Code ~ Exactly #{@secret_code.num_exact_matches(code_inst)} & Nearly #{@secret_code.num_near_matches(code_inst)} matches"
    end

    def ask_user_for_guess
        puts "Enter a code"
        user_input = gets.chomp
        user = Code.from_string(user_input)
        puts "Secret Code vs User ~ Exactly #{@secret_code.num_exact_matches(user)} & Nearly #{@secret_code.num_near_matches(user)} matches"
        @secret_code == user
    end
end
