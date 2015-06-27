require 'colorize'

def intro
  puts "Welcome to Grade School Math Trivia!!!".colorize(:blue)
  puts "Player 1, what's your name?".colorize(:light_blue)
  @player1 = gets.chomp!
  puts "Player 2, what's your name?".colorize(:light_blue)
  @player2 = gets.chomp!

  @players = [ {lives: 3, name: "#{@player1}"}, {lives: 3, name: "#{@player2}"} ]
  @turn = -1

end


def current_player
  @players[@turn % @players.count]
end

def generate_question

  @num1 = rand(1...20)
  @num2 = rand(1...20)

  operators = [:+, :-, :*]
  @op = operators.sample

  @result = @num1.send(@op, @num2).round(2)

end


def user_prompt
  
  print "#{current_player[:name]}, what is #{@num1} #{@op} #{@num2}? "
  @answer = gets.chomp.to_i

end


def verify
   
  if @answer == @result
    puts "You are correct!".colorize(:green)
  else 
    puts "You are wrong!".colorize(:red)
    current_player[:lives] -= 1
  end
end


def display_results
  puts "Sorry... #{current_player[:name]} you're a LOSER!!!".colorize(:yellow).on_red.underline
end

def game
  intro 

  loop do
    @turn += 1
    generate_question
    user_prompt
    verify
    break if current_player[:lives] == 0
  end
  display_results
end

game