#include "player.agc"
#include "gamearea.agc"


type TGameState
    CurrentState as integer
    LastState as integer
    
    Player as TPlayer
    GameArea as TGameArea
    
    
endtype

function GameStateInitGameArea(GameArea ref as TGameArea)
    GameAreaInit(GameState.GameArea, 0, 0)
    
    GameState.GameArea.PosX = (GetVirtualWidth() - GameState.GameArea.Width) / 2
endfunction

function GameStateInitPlayer(GameState ref as TGameState, Player ref as TPlayer, GameArea ref as TGameArea)
    
    PlayerInit(Player)
    
    PlayerWidth as float
    PlayerWidth = GetSpriteWidth(Player.Sprite)
    
    PlayerHeight as float
    PlayerHeight = GetSpriteHeight(Player.Sprite)
    
    Player.PosX = GameArea.PosX + ((GameArea.Width - PlayerWidth) / 2)
    Player.PosY = (GameArea.Height) - 2 * PlayerHeight
    
    
    
    
    
endfunction

    

function GameStateInit(GameState ref as TGameState)
    GameStateInitGameArea(GameState.GameArea)
    
    GameStateInitPlayer(GameState, GameState.Player, GameState.GameArea)
endfunction

function GameStateUpdate(GameState ref as TGameState)
    PlayerUpdate(GameState.Player)
endfunction



    
