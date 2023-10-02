class Player
    def initialize(current_game, board_marker)
        @current_game = current_game
        @board_marker = board_marker   
    end
    attr_reader :board_marker
end

class RealPlayer < Player
    def initialize
        
    end
end



module Logic
    #An array of winning board states 
    WIN_STATE = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

    class Game
        def initialize(player_one, player_two)
            
        end
    end
end