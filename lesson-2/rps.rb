# scissors cuts paper. paper covers rock. rock crushes lizard.
# lizard poisons spock. spock smashes scissors. scissors decapitates lizard.
# lizard eats paper. paper disproves spock. spock vaporizes rock.
# rock crushes scissors.

VALID_CHOICES = ['rock', 'paper', 'scissors', 'lizard', 'spock']

ABBREVIATIONS = ['r', 'p', 'sc', 'l', 'sp']

WINNING_PAIRS = { rock: ['scissors', 'lizard'],
                  paper: ['rock', 'spock'],
                  scissors: ['paper', 'lizard'],
                  lizard: ['spock', 'paper'],
                  spock: ['rock', 'scissors'] }

def win?(player1, player2)
  WINNING_PAIRS[player1.to_sym].include?(player2.to_s)
end

def clear_screen
  sleep(2.5)
  system('clear')
end

def prompt(message)
  Kernel.puts("=> #{message}")
end

def expand(abbrev)
  case abbrev
  when 'r' then 'rock'
  when 'p' then 'paper'
  when 'sc' then 'scissors'
  when 'l' then 'lizard'
  when 'sp' then 'spock'
  end
end

def display_results(player, computer)
  if win?(player, computer)
    prompt("You won!")
  elsif win?(computer, player)
    prompt("Computer won!")
  else
    prompt("It's a tie!")
  end
end

def display_greeting
  prompt("Welcome to ROCK-PAPER-SCISSORS-LIZARD-SPOCK!")
  prompt("The rules are: Rock crushes Scissors, Rock crushes Lizard,
          Paper covers Rock, Paper disproves Spock,
          Scissors cuts Paper, Scissors decapitates Lizard,
          Lizard eats Paper, Lizard poisons Spock,
          Spock vaporizes Rock, Spock smashes Scissors")
  prompt("The first one to 3 WINS is the champion!")
end

def display_score(player1_score, player2_score)
  prompt("You have won #{player1_score} times! The opponent has
        won #{player2_score} times!")
end

def display_truewinner(playerwins)
  if playerwins == 3
    prompt("You have defeated your opponent. CONGRATULATIONS CHAMPION!")
  else
    prompt("Close one but the computer won! Is this thing rigged?")
  end
end

# --------------------------------------
display_greeting

loop do
  prompt("Are you ready to play? Enter 'start' when you're ready: ")
  firstinput = gets.chomp.downcase
  if firstinput == 'start'
    break
  else
    abort "Goodbye!"
  end
end

loop do
  player_wins = 0
  computer_wins = 0
  loop do # main game loop
    choice = ''
    loop do
      prompt("Choose one: #{VALID_CHOICES}")
      prompt("Abbreviations are okay! 'r' for rock,
            'p' for paper, 'sc' for scissors,
            'l' for lizard, and 'sp' for spock. ")
      choice = Kernel.gets().chomp().downcase

      if VALID_CHOICES.include?(choice)
        break
      elsif ABBREVIATIONS.include?(choice)
        choice = expand(choice)
        break
      else
        prompt("That's not a valid choice!")
      end
    end

    computer_choice = VALID_CHOICES.sample

    Kernel.puts("You chose: #{choice}; Computer chose: #{computer_choice}")
    if win?(choice, computer_choice)
      player_wins += 1
    elsif win?(computer_choice, choice)
      computer_wins += 1
    end

    display_results(choice, computer_choice)

    display_score(player_wins, computer_wins)

    clear_screen

    break if player_wins == 3 || computer_wins == 3
  end
  display_truewinner(player_wins)
  clear_screen

  prompt("Do you want to play again? Enter 'y' for yes or any key to exit.")
  answer = gets.chomp.downcase
  if answer == 'y'
    redo
  else
    abort "Bye!"
  end
end
    
