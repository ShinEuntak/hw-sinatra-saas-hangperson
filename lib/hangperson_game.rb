class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
 
  attr_accessor :word,:guesses,:wrong_guesses
 
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    
  end
  
  def guess(letter)
    @letter = letter
    raise ArgumentError if @letter.nil? || @letter.empty? || @letter =~ /[^A-z]/
    if @letter =~ /[a-z]/
      if !(@guesses.include? @letter) && !(@wrong_guesses.include? @letter)
        if @word.include? @letter 
          @guesses << @letter
        else
          @wrong_guesses << @letter
        end
      end
      return true
    else
      return false
    end
  end
 
 
  def word_with_guesses()
    rword = @word
    rword.chars{
      |x| if !(@guesses.include? x)
        rword.gsub!(x,"-")
      end
    }
    return rword
  end
 
  def check_win_or_lose()
    count = 0
    @word.chars {|x|
      if @guesses.include? x
        count += 1
      end
    }
    if count == @word.length
      return :win
    elsif @wrong_guesses.length == 7
      return :lose
    else return :play
    end
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
