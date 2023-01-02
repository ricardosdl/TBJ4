
#constant GAME_AREA_WIDTH_RATIO 0.5
#constant GAME_AREA_HEIGHT_RATIO 1.0

type TGameArea
    PosX as float
    PosY as float
    
    Width as float
    Height as float
    
    ScrollVelocityY as float
    
    
endtype

function GameAreaInit(GameArea ref as TGameArea, PosX as float, PosY as float)
    GameArea.PosX = PosX
    GameArea.PosY = PosY
    
    GameArea.Width = GetVirtualWidth() * GAME_AREA_WIDTH_RATIO
    GameArea.Height = GetVirtualHeight() * GAME_AREA_HEIGHT_RATIO
    
    
endfunction
    
    
