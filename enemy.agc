#include "resources.agc"

#constant ENEMY_TYPE_SNAIL 0

#constant ENEMY_STATE_NO_STATE 0
#constant ENEMY_STATE_IDLE 1
#constant ENEMY_STATE_ATTACKING 2

#constant ENEMY_STATE_RETURN_CHANGED_STATE 1


type TEnemy
    PosX as float
    PosY as float
    
    VelX as float
    VelY as float
    Sprite as integer
    EnemyType as integer
    
    ScrollVelocityY as float
    
    Active as integer
    
    CurrentAnimation as string
    
    LastState as integer
    CurrentState as integer
    
    StateTimer as float
    
    
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
    
    Snail.Active = TRUE
    
    Snail.VelX = 0.0
    Snail.VelY = 0.0
    
    PlaySprite(Snail.Sprite, 4, 1, 1, 1)
    Snail.CurrentAnimation = "idle"
    
    Snail.LastState = Snail.CurrentState
    Snail.CurrentState = ENEMY_STATE_IDLE
    
    Snail.StateTimer = 0.0
    //~ PlaySprite(Snail.Sprite, 4, 1, 2, 3)
endfunction

function EnemyInit(Enemy ref as TEnemy, EnemyType as integer, PosX as float, PosY as float)
    
    select EnemyType
        case ENEMY_TYPE_SNAIL
            EnemySnailInit(Enemy, PosX, PosY)
        endcase
    endselect
        
endfunction

function EnemySnailUpdate(Snail ref as TEnemy, Player ref as TPlayer, TimeSlice as float)
    
    
    
    if Snail.CurrentState = ENEMY_STATE_IDLE
        DistanceToPlayer as float
        DistanceToPlayer = GetSpriteDistance(Snail.Sprite, Player.Sprite)
        Log("distance:" + Str(DistanceToPlayer))
        
        SnailWidth as float
        SnailWidth = GetSpriteWidth(Snail.Sprite)
        
        if DistanceToPlayer <= (SnailWidth * 4)
            if Snail.CurrentAnimation <> "walking"
                PlaySprite(Snail.Sprite, 4, 1, 2, 3)
                Snail.CurrentAnimation = "walking"
            endif
            
            Snail.CurrentState = ENEMY_STATE_ATTACKING
            Snail.StateTimer = 2.0
            Angle as float
            Angle = Atan2(Player.PosY - Snail.PosY, Player.PosX - Snail.PosX)
            
            Snail.VelX = 20 * Cos(Angle)
            Snail.VelY = 20 * Sin(Angle)
            
            exitfunction
            
        endif
        
    elseif Snail.CurrentState = ENEMY_STATE_ATTACKING
        if Snail.StateTimer <= 0.0
            Snail.CurrentState = ENEMY_STATE_IDLE
            Snail.VelX = 0.0
            Snail.VelY = 0.0
            Snail.CurrentAnimation = "idle"
            PlaySprite(Snail.Sprite, 4, 1, 1, 1)
            exitfunction
        endif
        
        dec Snail.StateTimer, TimeSlice
            
    endif
    
    inc Snail.PosX, Snail.VelX * TimeSlice
    inc Snail.PosY, Snail.VelY * TimeSlice
    
    
    
    
        
    
    
    
    
endfunction
    

function EnemyUpdate(Enemy ref as TEnemy, Player ref as TPlayer, TimeSlice as float)
    
    inc Enemy.PosY, Enemy.ScrollVelocityY * TimeSlice
    
    
    
    select Enemy.EnemyType
        case ENEMY_TYPE_SNAIL
            EnemySnailUpdate(Enemy, Player, TimeSlice)
        endcase
    endselect
    
    SetSpritePosition(Enemy.Sprite, Enemy.PosX, Enemy.PosY)
        
    
endfunction

function EnemyEnemiesUpdate(Enemies ref as TEnemy[], Player ref as TPlayer, TimeSlice as float)
    i as integer
    for i = 0 to Enemies.length
        if Enemies[i].Active
            EnemyUpdate(Enemies[i], Player, TimeSlice)
            Enemies[i].Active = GetSpriteInScreen(Enemies[i].Sprite)
        endif
    next
endfunction
    

