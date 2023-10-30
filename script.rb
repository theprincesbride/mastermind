require 'pry-byebug'

def game()
  gameboard = Gameboard.new
display_gameboard(gameboard.board)

  puts "Welcome to Mastermind!  You will be playing against a computer opponent for 12 rounds.  Would you like to review the rules before starting a game?"
  ask_rules()
  puts "Would you like to be the Codemaker or the Codebreaker?"
  role = ask_role
    if role == "codebreaker"
      codebreaker = CodebreakerHuman.new()
      codemaker = CodemakerComputer.new()
    elsif role == "codemaker"
      codemaker = CodemakerHuman.new
      codebreaker = CodebreakerComputer.new
    end
    master_sequence = codemaker.make_code_sequence()
    turn = 0
    until turn == 12
      master_copy = master_sequence.clone
      display_gameboard(gameboard.board)
      guess_sequence = codebreaker.guess()
      gameboard.board[turn].shift
      gameboard.board[turn].unshift(guess_sequence)
      display_gameboard(gameboard.board)
      feedback_array = codemaker.guess_feedback(guess_sequence, master_copy)
      gameboard.board[turn][1][:codekey] = feedback_array
      binding.pry
      display_gameboard(gameboard.board)
      if feedback_array == ["X", "X", "X", "X"] && codebreaker.type == "human"
        puts "Congratulations!  You guessed the correct sequence!  You won against the Codemaster!"
        puts "W---(^_^)---W"
        sleep 2
        puts "Do you want to start a new game?"
        loop do
        game_choice = gets
        game_choice = game_choice.chomp.downcase
        if game_choice == "yes" || game_choice == "y"
            puts "Yay!  You chose to play a new game!"
            sleep 2
            game()
        elsif game_choice == "no" || game_choice == "n"
            puts "Thank you for playing Mastermind.  Have a great day!"
            exit
        else
            puts "Do you want to play again?  Type yes, no, y or n."
        end
      end

      end
      turn += 1
    end
    if codemaker.type == "computer"
    puts "I'm sorry, you lost against your opponent!"
    puts "m---(v_v)---m"
    sleep 2
    puts "Don't give up!  Do you want to try again?"
    loop do
    game_choice = gets
    game_choice = game_choice.chomp.downcase
    if game_choice == "yes" || game_choice == "y"
        puts "Yay!  You chose to play a new game!"
        sleep 2
        game()
    elsif game_choice == "no" || game_choice == "n"
        puts "Thank you for playing Mastermind.  Have a great day!"
        exit
    else
        puts "Do you want to play again?  Type yes, no, y or n."
    end
  end
  end
end



class CodemakerHuman
  attr_accessor :choices, :type
  def initialize()
    @choices = ['red', 'orange', 'yellow', 'green', 'blue', 'purple']
    @type = "human"
  end
end

class CodemakerComputer < CodemakerHuman
  attr_accessor :choices, :type
  def initialize()
    @choices = ['red', 'orange', 'yellow', 'green', 'blue', 'purple']
    @type = "computer"
  end
  def make_code_sequence()
    code_array = []
    i = 0
    while i < 4
      code = @choices.sample
      code_array.push(code)
      i += 1
    end
    code_array
  end

  def guess_feedback(guess_array, master_array)
    feedback_array = ['-', '-', '-', '-']
    master_array_copy = master_array.clone
    i = 3
    while i >= 0
      if guess_array[i] == master_array_copy[i]
        feedback_array.pop
        feedback_array.unshift("X")
        master_array_copy.delete_at(i)
        i -= 1
      else
        i -= 1
      end
    end
      j = 0
      while j < master_array_copy.length
        if guess_array.include?(master_array_copy[j])
          feedback_array.insert(feedback_array.index('-'), "O")
          feedback_array.delete_at(feedback_array.index('-'))
          j += 1
        else
          j += 1
        end
      end
    puts "Please review the feedback from your opponent carefully.  Remember an 'X' means you have the right color in the right position, and an 'O' means you have the right color in the wrong position."
    p feedback_array
    sleep 2
    feedback_array
  end



end

class CodebreakerHuman
  attr_accessor :choices, :type
  def initialize()
    @choices = ['red', 'orange', 'yellow', 'green', 'blue', 'purple']
    @type = "human"
  end

  def guess()
  guess_array = []
  puts "Please choose your first color: red, orange, yellow, green, blue or purple."
  i = 0
    until i == 4
      color_choice = gets
      color_choice = color_choice.chomp.downcase
      if @choices.include?(color_choice) && i == 0
        puts "You chose #{color_choice} as your first color."
        guess_array.push(color_choice)
        p guess_array
        puts "Please choose your next color."
        i += 1
      elsif @choices.include?(color_choice) && i == 1
        puts "You chose #{color_choice} as your second color."
        guess_array.push(color_choice)
        p guess_array
        puts "Please choose your next color."
        i += 1
      elsif @choices.include?(color_choice) && i == 2
        puts "You chose #{color_choice} as your third color."
        guess_array.push(color_choice)
        p guess_array
        puts "Please choose your last color."
        i += 1
      elsif @choices.include?(color_choice) && i == 3
        puts "You chose #{color_choice} as your last color."
        guess_array.push(color_choice)
        p guess_array
        i += 1
      else
        puts "Please choose red, orange, yellow, green, blue or purple."
      end
    end
    guess_array
  end
end

class CodebreakerComputer < CodebreakerHuman
  attr_accessor :choices, :type
  def initialize()
    @choices = ['red', 'orange', 'yellow', 'green', 'blue', 'purple']
    @type = "computer"
  end

end

def display_gameboard(array)
  puts "--------------------------------------------------------"
  i = 0
  while i < array.length do
    p array[i]
      i += 1
    end
    puts "--------------------------------------------------------"
end

def ask_rules()
  rules_choice = gets
  rules_choice = rules_choice.chomp.downcase
  if rules_choice == 'yes' || rules_choice == 'y'
    puts "In Mastermind, you have the choice to be the Codebreaker or Codemaker."
    puts "At the start of the game, the Codemaker will choose a secret 'code' sequence of 4 colors from 6 possible colors (red, orange, yellow, green, blue, purple) that the Codebreaker must guess within 12 turns.  The sequence can contain repeating colors."
    puts "After each guess, the Codemaker will indicate to the Codebreaker if they have the correct color in the correct position with an 'X' mark and the correct color in the wrong position with an 'O' mark."
    puts "If the Codebreaker does not guess the correct sequence within 12 turns, the Codemaker wins!"
    puts "If the Codebreaker guesses the correct sequence within 12 turns, the Codebreaker wins!"

  elsif rules_choice == 'no' || rules_choice == 'n'

  else
    puts "Do you want to see the rules?  Please type 'yes' or 'no'."
    ask_rules()
  end
end

def ask_role()
  role_choice = gets
  role_choice = role_choice.chomp.downcase.delete(' ')
  if role_choice == "codebreaker"
    return "codebreaker"
  elsif role_choice == "codemaker"
    return "codemaker"
  else
    puts "Please choose if you would like to be the Codemaker or Codebreaker."
    ask_role()
  end
end



class Gameboard
  attr_accessor :board
  def initialize
  @board = [
    [['-', '-', '-', '-'], {codekey: ['-', '-', '-', '-']}],
    [['-', '-', '-', '-'], {codekey: ['-', '-', '-', '-']}],
    [['-', '-', '-', '-'], {codekey: ['-', '-', '-', '-']}],
    [['-', '-', '-', '-'], {codekey: ['-', '-', '-', '-']}],
    [['-', '-', '-', '-'], {codekey: ['-', '-', '-', '-']}],
    [['-', '-', '-', '-'], {codekey: ['-', '-', '-', '-']}],
    [['-', '-', '-', '-'], {codekey: ['-', '-', '-', '-']}],
    [['-', '-', '-', '-'], {codekey: ['-', '-', '-', '-']}],
    [['-', '-', '-', '-'], {codekey: ['-', '-', '-', '-']}],
    [['-', '-', '-', '-'], {codekey: ['-', '-', '-', '-']}],
    [['-', '-', '-', '-'], {codekey: ['-', '-', '-', '-']}],
    [['-', '-', '-', '-'], {codekey: ['-', '-', '-', '-']}],
]
  end
end

game()
