gameboard = [
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



def game()
  puts "Welcome to Mastermind!  You will be playing against a computer opponent for 12 rounds.  Would you like to review the rules before starting a game?"
  ask_rules()
  puts "Would you like to be the Codemaker or the Codebreaker?"

  loop do
    role = gets
    role = role.chomp.downcase.delete(' ')
    if role == "codebreaker"
      player = CodebreakerHuman.new
      computer = CodemakerComputer.new
      break
    elsif role == "codemaker"
      player = CodemakerHuman.new
      computer = CodebreakerComputer.new
      break
    else
      puts "Please choose if you would like to be the Codemaker or Codebreaker."
    end
  end


end

class CodemakerHuman
  attr_accessor :name, :choices
  def initialize
    @choices = ['red', 'orange', 'yellow', 'green', 'blue', 'purple']
  end
end

class CodemakerComputer < CodemakerHuman

end

class CodebreakerHuman
  attr_accessor :name, :choices
  def initialize
    @choices = ['red', 'orange', 'yellow', 'green', 'blue', 'purple']
  end
end

class CodebreakerComputer < CodebreakerHuman

end

def display_gameboard(array)
  i = 0
  while i < array.length do
    p array[i]
      i += 1
    end
end

def ask_rules()
  rules_choice = gets
  rules_choice = rules_choice.chomp.downcase
  if rules_choice == 'yes' || rules_choice == 'y'
    puts "In Mastermind, you have the choice to be the Codebreaker or Codemaker."
    puts "At the start of the game, the Codemaker will choose a secret 'code' sequence of 4 colors that the Codebreaker must guess within 12 turns.  After each guess, the Codemaker will indicate to the Codebreaker if they have the correct color in the correct position with an 'X' mark and the correct color in the wrong position with an 'O' mark.  If the Codebreaker does not guess the correct sequence within 12 turns, the Codemaker win!  If the Codebreaker guesses the correct sequence within 12 turns, the Codebreaker wins!"

  elsif rules_choice == 'no' || rules_choice == 'n'

  else
    puts "Do you want to see the rules?  Please type 'yes' or 'no'."
    ask_rules()
  end
end

game()
