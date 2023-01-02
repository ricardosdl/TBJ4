#include "resources.agc"


type TPlayer
    PosX as float
    PosY as float
    Sprite as integer
    
    
    
endtype

function PlayerInit(Player ref as TPlayer)
    //~ Player.Sprite = CreateSprite(0)
    //~ AddSpriteAnimationFrame(Player.Sprite, PLAYER_BACK_ANIMATION[0])
    //~ AddSpriteAnimationFrame(Player.Sprite, PLAYER_BACK_ANIMATION[1])
    //~ AddSpriteAnimationFrame(Player.Sprite, PLAYER_BACK_ANIMATION[2])
    
    Player.Sprite = CreateSprite(0)
    AddSpriteAnimationFrame(Player.Sprite, PLAYER_RIGHT_WALK_ANIMATION[0])
    AddSpriteAnimationFrame(Player.Sprite, PLAYER_RIGHT_WALK_ANIMATION[1])
    AddSpriteAnimationFrame(Player.Sprite, PLAYER_RIGHT_WALK_ANIMATION[2])
    AddSpriteAnimationFrame(Player.Sprite, PLAYER_RIGHT_WALK_ANIMATION[3])

    
    SetSpritePosition(PLayer.Sprite, 50, 50)
    
    PlaySprite(Player.Sprite, 4)
    //SetSpriteFlip(Player.Sprite, 1, 0)
    
endfunction

function PlayerUpdate(Player ref as TPlayer)
    SetSpritePosition(PLayer.Sprite, Player.PosX, Player.PosY)
endfunction
    
