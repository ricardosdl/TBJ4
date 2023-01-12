#include "resources.agc"

#constant ENEMY_TYPE_SNAIL 0


type TEnemy
    PosX as float
    PosY as float
    Sprite as integer
    EnemyType as integer
    
    ScrollVelocityY as float
    
    State as integer
    
    WakeUpTimer as float
    
    Active as integer
    
    
endtype

function EnemySetPosition(Enemy ref as TEnemy, PosX as float, PosY as float)
    Enemy.PosX = PosX
    Enemy.PosY = PosY
    
    SetSpritePosition(Enemy.Sprite, Enemy.PosX, Enemy.PosY)
    
endfunction

function EnemySnailInit(Snail ref as TEnemy, PosX as float, PosY as float)
    
    Snail.Sprite = CreateSprite(0)
    
    AddSpriteAnimationFrame(Snail.Sprite, ENEMY_SNAIL_ANIMATION[0])
    AddSpriteAnimationFrame(Snail.Sprite, ENEMY_SNAIL_ANIMATION[1])
    AddSpriteAnimationFrame(Snail.Sprite, ENEMY_SNAIL_ANIMATION[2])

    EnemySetPosition(Snail, PosX, PosY)
    
    PlaySprite(Snail.Sprite, 4, 1, 1, 1)
endfunction

function EnemyInit(Enemy ref as TEnemy, EnemyType as integer, PosX as float, PosY as float)
    
    select EnemyType
        case ENEMY_TYPE_SNAIL
            EnemySnailInit(Enemy, PosX, PosY)
        endcase
    endselect
        
endfunction

function EnemySnailUpdate(Snail ref as TEnemy, TimeSlice as float)
    
    
endfunction
    

function EnemyUpdate(Enemy ref as TEnemy, TimeSlice as float)
    
    inc Enemy.PosY, Enemy.ScrollVelocityY * TimeSlice
    
    SetSpritePosition(Enemy.Sprite, Enemy.PosX, Enemy.PosY)
    
    select Enemy.EnemyType
        case ENEMY_TYPE_SNAIL
            EnemySnailUpdate(Enemy, TimeSlice)
        endcase
    endselect
        
    
endfunction

function EnemyEnemiesUpdate(Enemies ref as TEnemy[], TimeSlice as float)
    i as integer
    for i = 0 to Enemies.length
        EnemyUpdate(Enemies[i], TimeSlice)
    next
endfunction
    

