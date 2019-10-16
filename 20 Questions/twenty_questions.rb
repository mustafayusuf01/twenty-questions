class Game
  def initialize
    @file = File.new("downloads/RubyExercises/boris_johnson.dat")
    @question = []
    @question_match = false
    @questions_count = 20
    @person = @file.readlines.first.chomp
    rawwords = @file.readlines("/n")
    @keywords = rawwords.each{|a| a.chomp}
  end

  def take_question
      puts "Ask a question: "
      intake = gets.chomp
      @question = intake.split(" ")
      @questions_count -= 1
      check_keywords()
  end

  def check_keywords
    p1 = Regexp.new(@person, Regexp::IGNORECASE)
    @question.each{|q| a = Regexp.new(q, Regexp::IGNORECASE)
      if @keywords.first =~ p1
        winner()
      elsif @keywords.any?{|k| k.match(a)}
        @question_match = true
        return
      else
        @question_match = false
      end
    }
    answer_question()
  end

  def answer_question
    if @question_match == true
      puts "Yes"
    else
      puts "No"
    end
    puts "You have #{@questions_count} left."
    if @questions_count == 0
      game_over()
    else
        take_question()
    end
  end

  def game_over
    puts "You Lose! I'm #{@person.capitalize}! Hahaha"
    exit
  end

  def winner
    puts "You win! It's me #{@person.capitalize}! Well done!"
    exit
  end

  private :game_over, :winner
end

g = Game.new
g.take_question()
