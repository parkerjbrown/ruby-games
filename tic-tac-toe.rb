class TicTacToe
  def initialize
    $board = {A1: " ", A2: " ", A3: " ",  B1: " ",  B2: " ",  B3: " ",  C1: " ",  C2: " ",  C3: " "}
    @winning_moves = [[:A1, :A2, :A3], [:B1, :B2, :B3], [:C1, :C2, :C3], 
                      [:A1, :B1, :C1], [:A2, :B2, :C2], [:A3, :B3, :C3], 
                      [:A1, :B2, :C3], [:A3, :B2, :C1]]
    @players = []
    @game_over = false
  end

  def play
    display_welcome
    display_board

    until @game_over
      @players.each do |player|
        player.take_turn
        display_board
        check_for_winner(player)
        break if @game_over
      end
    end
  end

  private

  def display_welcome
    puts "
 ╔╦╗╦╔═╗  ╔╦╗╔═╗╔═╗  ╔╦╗╔═╗╔═╗
  ║ ║║  ── ║ ╠═╣║  ── ║ ║ ║║╣ 
  ╩ ╩╚═╝   ╩ ╩ ╩╚═╝   ╩ ╚═╝╚═╝"
    puts " > Enter 1 for Single-Player"
    puts " > Enter 2 for Double-Player"
    print " Game Mode: "
    loop do
      mode = gets.chomp.to_i
      if mode == 1 || mode == 2
        select_game_mode(mode)
        break
      else
        print " Invalid game mode. Please try again: "
      end
    end
    puts "\n DIRECTIONS: Try to get three in a row by marking spaces on the board!"
    puts " Use board coordinates (A1, B3, C2, etc.) when making moves."
  end

  def display_board
    puts "
     A   B   C
   ╔═══╦═══╦═══╗
 1 ║ #{$board[:A1]} ║ #{$board[:B1]} ║ #{$board[:C1]} ║
   ╠═══╬═══╬═══╣
 2 ║ #{$board[:A2]} ║ #{$board[:B2]} ║ #{$board[:C2]} ║
   ╠═══╬═══╬═══╣
 3 ║ #{$board[:A3]} ║ #{$board[:B3]} ║ #{$board[:C3]} ║
   ╚═══╩═══╩═══╝"
  end

  def select_game_mode(number_of_players)
    add_player("Player 1", "X")
    add_player("Player 2", "O") if number_of_players == 2
    add_bot("PlayerBot 9000", "O") if number_of_players == 1
  end

  def add_player(name, symbol)
    player = Player.new(name, symbol)
    @players << player
    puts " > Adding player '#{name}' with symbol of '#{symbol}'"
  end

  def add_bot(name, symbol)
    bot = Bot.new(name, symbol)
    @players << bot
    puts " > Adding bot '#{name}' with symbol of '#{symbol}'"
  end
  
  def check_for_winner(player)
    @winning_moves.each_with_index do |value, index|
      if @winning_moves[index].all? { |move| player.moves.include?(move) }
        puts "\n WINNER: #{player.name}"
        puts "\n Thanks for playing!"
        puts ""
        @game_over = true
      end
    end
  end
end

class Player
  attr_accessor :name, :symbol, :moves

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
    @moves = []
  end

  def take_turn
    print "\n #{@name} [#{@symbol}] to move: "
    loop do
      move = gets.chomp.upcase.to_sym
      if $board[move] == " "
        @moves << move
        $board[move] = @symbol
        break
      elsif $board[move] == nil
        print " This space does not exist! Please try again: "
      elsif $board[move].scan(/\w/)
        print " This space has already been taken! Please try again: "
      else
        print " Invalid syntax. Please try again: "
      end
    end
  end
end

class Bot < Player
  def take_turn
    loop do
      move = $board.keys.sample.to_sym
      if $board[move] == " "
        @moves << move
        $board[move] = @symbol
        puts "\n #{@name} [#{@symbol}] has made a move at #{move.to_s}!"
        break
      end
    end
  end
end

game = TicTacToe.new
game.play