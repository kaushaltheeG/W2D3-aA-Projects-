class Code
  POSSIBLE_PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow
  }

  def self.valid_pegs?(char_arr)
    char_arr.all? {|char| POSSIBLE_PEGS.include?(char.upcase)}
  end

  attr_reader :pegs

  def initialize(char_arr)
    raise ArgumentError.new "invalide character array" if !Code.valid_pegs?(char_arr)
    @pegs = char_arr.map {|char| char.upcase}
  end

  def self.random(len)
    arr = Array.new(len)
    options = ["R", "G", "B", "Y"]
    arr.map! {|ele| ele = options.shuffle[0]}
    instance = Code.new(arr)
    
  end

  def self.from_string(peg_str)
    arr = peg_str.split('')
    instance = Code.new(arr)
  end

  def [](idx)
    @pegs[idx]
  end

  def length
    @pegs.length
  end

  def num_exact_matches(guess)
    #guess is a Code instance
    count = 0
    guess.pegs.each.with_index do |color, i|
      count += 1 if color == self[i]
    end
    count
  end

  def num_near_matches(guess)
    #guess is a Code instance
    # count = 0
    # @pegs.each.with_index do |color, i|
    #   p "guess: #{guess[i]} peg: #{@pegs[i]}"
    #   p guess[0...i]
    #   p guess[i+1...guess.length]
    #   p (guess[0...i].include?(color) || guess[i+1...guess.length].include?(color)) 
    #   p guess[i] != @pegs[i] && (guess[0...i].include?(color) || guess[i+1...guess.length].include?(color)) 
    #   p '-------'
    #   count += 1 if guess[i] != @pegs[i] && (guess[0...i].include?(color) || guess[i+1...guess.length].include?(color)) 
      
    # end
    
    # count
    #^^ above one is a failed attempt 
    
    guess_copy , pegs_copy = [], []
    (0...length).each do |idx|
      if guess[idx] != self.pegs[idx]
        guess_copy << guess[idx]
        pegs_copy << self.pegs[idx]
      end
    end
    p "Guess: #{guess_copy}"
    p "pegs #{pegs_copy}"
    (guess_copy & pegs_copy).length
  end

  def ==(other_code)
    #other_code is an instance of Code
    @pegs == other_code.pegs
  end




end

