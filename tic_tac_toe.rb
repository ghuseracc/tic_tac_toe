module Logic
    #An array of winning board states 
    WIN_STATE = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

    class Game
        def initialize(player_one, player_two)
            @game_players = [player_one.new(self, "X"), player_two.new(self, "O")]
            #Create an empty board
            @game_board = Array.new(9)
            #Randomize which player goes first
            @current_turn_player_id =  rand 2

            puts "Player #{current_turn_player_id} is going first."
        end
        attr_reader :game_board, :current_turn_player_id

        def play_game
            loop do
              place_board_marker(current_turn_player)
              
              if current_player_has_won?(current_turn_player)
                puts "Player #{current_turn_player_id} has won the game!"
                show_game_board
                return
              elsif game_board_full?
                puts "It's a draw."
                show_game_board
                return
              end
              
              change_player_turn

              end
        end

        #Check game board for player markers
        def empty_board_positions
            (0..8).select {|position| @game_board[position].nil?}
          end
          
          def place_board_marker(player)
            position = player.choose_board_position
            puts "#{player} selects #{player.board_marker} position #{position}"
            @game_board[position] = player.board_marker
          end
          
          #Check current board state for any winner 
          def current_player_has_won?(player)
            WIN_STATE.any? do |state|
              state.all? {|position| @game_board[position] == player.board_marker}
            end
          end
          
          def game_board_full?
            empty_board_positions.empty?
          end
          
          def next_player_id
            1 - @current_turn_player_id
          end
          
          def change_player_turn
            @current_turn_player_id = next_player_id
          end
          
          def current_turn_player
            @game_players[current_turn_player_id]
          end
          
          def show_game_board
            col_separator, row_separator = " | ", "~~+~~~+~~"
            label_for_position = lambda{|position| @game_board[position] ? @game_board[position] : position}
            
            row_for_display = lambda{|row| row.map(&label_for_position).join(col_separator)}
            row_positions = [[0,1,2], [3,4,5], [6,7,8]]
            rows_for_display = row_positions.map(&row_for_display)
            puts rows_for_display.join("\n" + row_separator + "\n")
          end
        end

    class Player
        def initialize(current_game, board_marker)
            @current_game = current_game
            @board_marker = board_marker   
        end
        attr_reader :board_marker
    end

    class RealPlayer < Player
        def choose_board_position
            @current_game.show_game_board
            loop do
              print "Select your #{board_marker} position: "
              board_position = gets.to_i
              return board_position if @current_game.empty_board_positions.include?(board_position)
              puts "Position #{board_position} is not available. Try again."
            end
        end
    end

    def to_s
        "Player"
    end
end

include Logic

Game.new(RealPlayer, RealPlayer).play_game

