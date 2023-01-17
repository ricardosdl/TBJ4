#include "player.agc"
#include "gamearea.agc"
#include "enemy.agc"


type TGameState
    CurrentState as integer
    LastState as integer
    
    Player as TPlayer
    GameArea as TGameArea
    Enemies as TEnemy[]
    
    
endtype

function GameStateInitGameArea(GameArea ref as TGameArea)
    GameAreaInit(GameArea, 0, 0)
    
    GameAreaSetPosition(GameArea, (GetVirtualWidth() - GameArea.Width) / 2, GameArea.PosY)
    
    //GameArea.PosX = (GetVirtualWidth() - GameArea.Width) / 2
    
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

function GameStateInitEnemies(GameState ref as TGameState)
    Enemy as TEnemy
    
    EnemyInit(Enemy, ENEMY_TYPE_SNAIL, 0, 0)
    
    EnemyPosX as float
    EnemyPosX = Random(GameState.GameArea.PosX, GameState.GameArea.PosX + GameState.GameArea.Width - GetSpriteWidth(Enemy.Sprite))
    
    EnemySetPosition(Enemy, EnemyPosX, 10)
    
    Enemy.ScrollVelocityY = GameState.GameArea.ScrollVelocityY
    
    GameState.Enemies.insert(Enemy)
endfunction
    

function GameStateInit(GameState ref as TGameState)
    GameStateInitGameArea(GameState.GameArea)
    
    GameStateInitPlayer(GameState, GameState.Player, GameState.GameArea)
    
    GameStateInitEnemies(GameState)
endfunction

function GameStateUpdate(GameState ref as TGameState, TimeSlice as float)
    GameAreaUpdate(GameState.GameArea, TimeSlice)
    PlayerUpdate(GameState.Player, TimeSlice)
    EnemyEnemiesUpdate(GameState.Enemies, GameState.Player, TimeSlice)
endfunction



    
