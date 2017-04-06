require './support-files/colorize.rb'

class Mastermind
  attr_accessor #something

  def initialize
    $board = {P0: "1", P1: "2", P2: "3", P3: "4"}
    @secret_code = {P0: " ", P1: " ", P2: " ", P3: " "}
    @colors = {RED: red(' '), GREEN: green(' '), YELLOW: yellow(' '), BLUE: blue(' '), PURPLE: purple(' '), CYAN: teal(' ')}
    @win = false
  end

  def play
    display_welcome
    12.times do |x|
      make_guess(x + 1)
      check_for_includes
      check_for_matches
      break if @win == true
    end
    display_game_over
    puts "\n The secret code was:"
    display_answer_board
    puts ""
  end

  def display_welcome
    puts "
 ╔╦╗╔═╗╔═╗╔╦╗╔═╗╦═╗╔╦╗╦╔╗╔╔╦╗
 ║║║╠═╣╚═╗ ║ ║╣ ╠╦╝║║║║║║║ ║║
 ╩ ╩╩ ╩╚═╝ ╩ ╚═╝╩╚═╩ ╩╩╝╚╝═╩╝"
    puts " > Enter 1 for Single-Player"
    puts " > Enter 2 for Double-Player"
    print " Game Mode: "
    loop do
      mode = gets.chomp.to_i
      if mode == 1 || mode == 2
        generate_code(mode)
        break
      else
        print " Invalid game mode. Please try again: "
      end
    end
    puts "\n GUESSER: Try to guess the four-color secret code in 12 turns!"
    display_board
  end

  def generate_code(mode)
    if mode == 1
      # Automatically generate code
      @secret_code.keys.each do |key|
        color = @colors.values.sample
        @secret_code[key] = color
      end
    else
      # User generates code
      puts "\n MASTERMIND: Enter the four-color secret code below while GUESSER looks away!"
      puts " Use the provided color chart as reference:"
      display_board
      display_pieces
      puts "\n Enter the secret code one color at a time: "
      4.times do |x|
        loop do
        print "\n > Color #{(x + 1).to_s}: "
        code = gets.chomp.upcase.to_sym
          if @colors.keys.include?(code)
            position = ("P" + x.to_s).to_sym
            @secret_code[position] = @colors[code]
            break
          else
            print "\n Invalid color. Please try again: "
          end
        end
      end
      display_answer_board
      print "\n This is your secret code. Press ENTER to start the game! "
      $stdin.gets
    end
    print %x{clear} 
  end

  def make_guess(iteration)
    loop do
      puts "\n GUESS #{iteration.to_s}/12"
      display_pieces
      4.times do |x|
        loop do
        print "\n > Color #{(x + 1).to_s}: "
        code = gets.chomp.upcase.to_sym
          if @colors.keys.include?(code)
            position = ("P" + x.to_s).to_sym
            $board[position] = @colors[code]
            break
          else
            print "\n Invalid color. Please try again: "
          end
        end
      end
      display_board
      break
    end
  end

  def check_for_matches
    matches = 0
    $board.keys.each do |key|
      matches += 1 if $board[key] == @secret_code[key]
    end
    puts " > Right color AND right position: #{matches}"
    @win = true if matches == 4
  end

  def check_for_includes
    # Make this count NUMBER OF TIMES
    includes = 0
    @secret_code.values.each do |value|
      includes += 1 if $board.values.include?(value)
    end
    puts "\n > Right color: #{includes}"
  end

  def display_pieces
    puts "\n RED: #{red(' ')} | GREEN: #{green(' ')} | YELLOW: #{yellow(' ')} | BLUE: #{blue(' ')} | PURPLE: #{purple(' ')} | CYAN: #{teal(' ')}"
  end

  def display_board
    puts "
 ╔═══╦═══╦═══╦═══╗
 ║ #{$board[:P0]} ║ #{$board[:P1]} ║ #{$board[:P2]} ║ #{$board[:P3]} ║
 ╚═══╩═══╩═══╩═══╝"
  end

  def display_answer_board
    puts "
 ╔═══╦═══╦═══╦═══╗
 ║ #{@secret_code[:P0]} ║ #{@secret_code[:P1]} ║ #{@secret_code[:P2]} ║ #{@secret_code[:P3]} ║
 ╚═══╩═══╩═══╩═══╝"
  end

  def display_game_over
    if @win == true
      puts "\n The #{green(" GUESSER ")} has won!"
    else
      puts "\n The #{red(" MASTERMIND ")} has won!"
    end
  end
end

game = Mastermind.new
game.play