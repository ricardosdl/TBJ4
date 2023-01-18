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
    
    Player.ScrollVelocityY = GameState.GameArea.ScrollVelocityY
    
    PlayerWidth as float
    PlayerWidth = GetSpriteWidth(Player.Sprite)
    
    PlayerHeight as float
    PlayerHeight = GetSpriteHeight(Player.Sprite)
    
    Player.PosX = GameArea.PosX + ((GameArea.Width - PlayerWidth) / 2)
    Player.PosY = (GameArea.Height) - 2 * PlayerHeight
    
    
    
    
    
endfunction

function GameStateInitEnemies(GameState ref as TGameState)
    IdxInactiveEnemy as integer
    IdxInactiveEnemy = EnemyGetIdxInactiveEnemy(GameState.Enemies)
    
    EnemyInit(GameState.Enemies[IdxInactiveEnemy], ENEMY_TYPE_SNAIL, 0, 0)
    
    EnemyPosX as float
    EnemyPosX = Random(GameState.GameArea.PosX, GameState.GameArea.PosX + GameState.GameArea.Width - GetSpriteWidth(GameState.Enemies[IdxInactiveEnemy].Sprite))
    
    EnemySetPosition(GameState.Enemies[IdxInactiveEnemy], EnemyPosX, 10)
    
    GameState.Enemies[IdxInactiveEnemy].ScrollVelocityY = GameState.GameArea.ScrollVelocityY
endfunction
    

function GameStateInit(GameState ref as TGameState)
    GameStateInitGameArea(GameState.GameArea)
    
    GameStateInitPlayer(GameState, GameState.Player, GameState.GameArea)
    
    GameStateInitEnemies(GameState)
endfunction

function GameStateCheckPlayerBoundaries(GameState ref as TGameState)
    GameArea as TGameArea
    GameArea = GameState.GameArea
    
    Player as TPlayer
    Player = GameState.Player
    
    //check x axis
    if Player.PosX < GameArea.PosX
        GameState.Player.PosX = GameArea.PosX
    endif
    
    if Player.PosX + GetSpriteWidth(Player.Sprite) > GameArea.PosX + GameArea.Width
        GameState.Player.PosX = (GameArea.PosX + GameArea.Width) - GetSpriteWidth(Player.Sprite)
    endif
    
    //check y axis
    if Player.PosY < GameArea.PosY
        GameState.Player.PosY = GameArea.PosY
    endif
    
    if Player.PosY + GetSpriteHeight(Player.Sprite) > GameArea.PosY + GameArea.Height
        GameState.Player.PosY = (GameArea.PosY + GameArea.Height) - GetSpriteHeight(Player.Sprite)
    endif
    
endfunction

function GameStateCheckEnemiesBoundaries(GameState ref as TGameState)
    
    GameArea as TGameArea
    GameArea = GameState.GameArea
    
    i as integer
    for i = 0 to GameState.Enemies.length
        if Not GameState.Enemies[i].Active
            continue
        endif
            
        Enemy as TEnemy
        Enemy = GameState.Enemies[i]
        
        if Enemy.PosX < GameArea.PosX
            GameState.Enemies[i].PosX = GameArea.PosX
        endif
        
        if Enemy.PosX + GetSpriteWidth(Enemy.Sprite) > GameArea.PosX + GameArea.Width
            GameState.Enemies[i].PosX = (GameArea.PosX + GameArea.Width) - GetSpriteWidth(Enemy.Sprite)
        endif
            
            
        
    next
    
    
endfunction

function GameStateUpdate(GameState ref as TGameState, TimeSlice as float)
    GameAreaUpdate(GameState.GameArea, TimeSlice)
    
    PlayerUpdate(GameState.Player, TimeSlice)
    
    GameStateCheckPlayerBoundaries(GameState)
    
    EnemyEnemiesUpdate(GameState.Enemies, GameState.Player, TimeSlice)
    
    GameStateCheckEnemiesBoundaries(GameState)
    
endfunction



    
