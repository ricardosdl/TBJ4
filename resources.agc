#constant SPRITE_SHEET_FILE_NAME "tbj4_compilation_sf.png"
#constant SPRITE_SHEET_IMAGE_ID 1

#constant PLAYER_BACK_ANIMATION_END_FRAME 2
#constant PLAYER_BACK_ANIMATION_NAME "playerback"

#constant PLAYER_RIGHT_WALK_ANIMATION_END_FRAME 3
#constant PLAYER_RIGHT_WALK_ANIMATION_NAME "playerrightwalk"

#constant GROUND_TILE_SAND_NAME "graoundtilesand"
#constant GROUND_TILE_SAND_END_FRAME 1

global PLAYER_BACK_ANIMATION as integer[PLAYER_BACK_ANIMATION_END_FRAME]
global PLAYER_RIGHT_WALK_ANIMATION as integer[PLAYER_RIGHT_WALK_ANIMATION_END_FRAME]

global GROUND_TILE_SAND_0 as integer
global GROUND_TILE_SAND_1 as integer

function LoadPlayerAnimations()
    for i = 0 to PLAYER_BACK_ANIMATION_END_FRAME
        PLAYER_BACK_ANIMATION[i] = LoadSubImage(SPRITE_SHEET_IMAGE_ID, PLAYER_BACK_ANIMATION_NAME + str(i))
    next
    
    for i = 0 to PLAYER_RIGHT_WALK_ANIMATION_END_FRAME
        PLAYER_RIGHT_WALK_ANIMATION[i] = LoadSubImage(SPRITE_SHEET_IMAGE_ID, PLAYER_RIGHT_WALK_ANIMATION_NAME + str(i))
    next
        
        
endfunction

function LoadGroundTiles()
    GROUND_TILE_SAND_0 = LoadSubImage(SPRITE_SHEET_IMAGE_ID, GROUND_TILE_SAND_NAME + "0")
    GROUND_TILE_SAND_1 = LoadSubImage(SPRITE_SHEET_IMAGE_ID, GROUND_TILE_SAND_NAME + "1")
endfunction
    
    

function LoadResources()
    LoadImage(SPRITE_SHEET_IMAGE_ID, SPRITE_SHEET_FILE_NAME, 1)
    SetImageMagFilter(SPRITE_SHEET_IMAGE_ID, 0)
    
    LoadPlayerAnimations()
    
    LoadGroundTiles()
    
    
endfunction
    
