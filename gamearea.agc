
#constant GAME_AREA_WIDTH_RATIO 0.5
#constant GAME_AREA_HEIGHT_RATIO 1.0

#constant GROUND_TILE_WIDTH 8
#constant GROUND_TILE_HEIGHT 8

type TGroundTile
    PosX as float
    PosY as float
    Sprite as integer
endtype
    

type TGround
    Tiles as TGroundTile[]
    WidthInTiles as integer
    HeightInTiles as integer
    StartPosX as float
    StartPosY as float
    
endtype
    

type TGameArea
    PosX as float
    PosY as float
    
    Width as float
    Height as float
    
    ScrollVelocityY as float
    
    Ground as TGround
    
endtype

function GameAreaInitGround(GameArea ref as TGameArea, Ground ref as TGround)
    
    Ground.StartPosX = GameArea.PosX
    Ground.StartPosY = GameArea.PosY - (GROUND_TILE_HEIGHT)
    
    Ground.WidthInTiles = GameArea.Width / GROUND_TILE_WIDTH
    Ground.HeightInTiles = (GameArea.Height / GROUND_TILE_HEIGHT) + 1
    
    Ground.Tiles.length = Ground.WidthInTiles * Ground.HeightInTiles
    
    for x = 0 to Ground.WidthInTiles - 1
        for y = 0 to Ground.HeightInTiles - 1
            //gets the tile index in the Tiles array
            IdxTile = y * Ground.WidthInTiles + x
            Ground.Tiles[IdxTile].PosX = Ground.StartPosX + x * GROUND_TILE_WIDTH
            Ground.Tiles[IdxTile].PosY = Ground.StartPosY + y * GROUND_TILE_HEIGHT
            
            //decides witch image wil be used on the sprite
            GroundImage as integer
            if Random(1, 100) < 33
                GroundImage = GROUND_TILE_SAND_0
            else
                GroundImage = GROUND_TILE_SAND_1
            endif
            
            Ground.Tiles[IdxTile].Sprite = CreateSprite(GroundImage)
            SetSpritePosition(Ground.Tiles[IdxTile].Sprite, Ground.Tiles[IdxTile].PosX, Ground.Tiles[IdxTile].PosY)
        next y
    next x
        
    
    
    
endfunction
    

function GameAreaInit(GameArea ref as TGameArea, PosX as float, PosY as float)
    GameArea.PosX = PosX
    GameArea.PosY = PosY
    
    GameArea.Width = GetVirtualWidth() * GAME_AREA_WIDTH_RATIO
    GameArea.Height = GetVirtualHeight() * GAME_AREA_HEIGHT_RATIO
    
    GameArea.ScrollVelocityY = 10
    
    GameAreaInitGround(GameArea, GameArea.Ground)
    
    
    
    
endfunction

function GameAreaSetPosition(GameArea ref as TGameArea, PosX as float, PosY as float)
    GameArea.PosX = PosX
    GameArea.PosY = PosY
    
    GameArea.Ground.StartPosX = GameArea.PosX
    GameArea.Ground.StartPosY = GameArea.PosY - (GROUND_TILE_HEIGHT)
    
    for x = 0 to GameArea.Ground.WidthInTiles - 1
        for y = 0 to GameArea.Ground.HeightInTiles - 1
            //gets the tile index in the Tiles array
            IdxTile = y * GameArea.Ground.WidthInTiles + x
            GameArea.Ground.Tiles[IdxTile].PosX = GameArea.Ground.StartPosX + x * GROUND_TILE_WIDTH
            GameArea.Ground.Tiles[IdxTile].PosY = GameArea.Ground.StartPosY + y * GROUND_TILE_HEIGHT
            
            SetSpritePosition(GameArea.Ground.Tiles[IdxTile].Sprite, GameArea.Ground.Tiles[IdxTile].PosX, GameArea.Ground.Tiles[IdxTile].PosY)
        next y
    next x
    
    
endfunction

function GameAreaUpdateGround(GameArea ref as TGameArea, TimeSlice as float)
    IdxTile as integer
    LowestY as float = 10
    RepositionatedGroudTiles as integer[]
    for x = 0 to GameArea.Ground.WidthInTiles - 1
        for y = 0 to GameArea.Ground.HeightInTiles - 1
            //gets the tile index in the Tiles array
            IdxTile = y * GameArea.Ground.WidthInTiles + x
            
            if GameArea.Ground.Tiles[IdxTile].PosY > GameArea.PosY + GameArea.Height
                //out of sight, shoud put it back on the top of game area
                //GameArea.Ground.Tiles[IdxTile].PosY = GameArea.Ground.StartPosY
                
                RepositionatedGroudTiles.insert(IdxTile)
                
                GroundImage as integer
                if Random(1, 100) < 33
                    GroundImage = GROUND_TILE_SAND_0
                else
                    GroundImage = GROUND_TILE_SAND_1
                endif
                
                SetSpriteImage(GameArea.Ground.Tiles[IdxTile].Sprite, GroundImage)
            endif
            
            inc GameArea.Ground.Tiles[IdxTile].PosY, TimeSlice * GameArea.ScrollVelocityY
            //GameArea.Ground.Tiles[IdxTile].PosY = GameArea.Ground.Tiles[IdxTile].PosY + TimeSlice * GameArea.ScrollVelocityY
            if GameArea.Ground.Tiles[IdxTile].PosY < LowestY
               LowestY =  GameArea.Ground.Tiles[IdxTile].PosY
            endif
                
            
            SetSpritePosition(GameArea.Ground.Tiles[IdxTile].Sprite, GameArea.Ground.Tiles[IdxTile].PosX, GameArea.Ground.Tiles[IdxTile].PosY)
            
        next y
    next x
    
    Log("size RepositionatedGroudTiles:" + str(RepositionatedGroudTiles.length))
    
    for i = 0 to RepositionatedGroudTiles.length
        IdxTile = RepositionatedGroudTiles[i]
        GameArea.Ground.Tiles[IdxTile].PosY = LowestY - GROUND_TILE_HEIGHT
        SetSpritePosition(GameArea.Ground.Tiles[IdxTile].Sprite, GameArea.Ground.Tiles[IdxTile].PosX, GameArea.Ground.Tiles[IdxTile].PosY)
    next i
        
    
    
endfunction
    

function GameAreaUpdate(GameArea ref as TGameArea, TimeSlice as float)
    GameAreaUpdateGround(GameArea, TimeSlice)
endfunction
    
    
    
