#constant SPRITE_SHEET_FILE_NAME "tbj4_compilation_sf.png"
#constant SPRITE_SHEET_IMAGE_ID 1

#constant PLAYER_BACK_ANIMATION_END_FRAME 2
#constant PLAYER_BACK_ANIMATION_NAME "playerback"

#constant PLAYER_RIGHT_WALK_ANIMATION_END_FRAME 3
#constant PLAYER_RIGHT_WALK_ANIMATION_NAME "playerrightwalk"

global PLAYER_BACK_ANIMATION as integer[PLAYER_BACK_ANIMATION_END_FRAME]
global PLAYER_RIGHT_WALK_ANIMATION as integer[PLAYER_RIGHT_WALK_ANIMATION_END_FRAME]

function LoadPlayerAnimations()
    for i = 0 to PLAYER_BACK_ANIMATION_END_FRAME
        PLAYER_BACK_ANIMATION[i] = LoadSubImage(SPRITE_SHEET_IMAGE_ID, PLAYER_BACK_ANIMATION_NAME + str(i))
    next
    
    for i = 0 to PLAYER_RIGHT_WALK_ANIMATION_END_FRAME
        PLAYER_RIGHT_WALK_ANIMATION[i] = LoadSubImage(SPRITE_SHEET_IMAGE_ID, PLAYER_RIGHT_WALK_ANIMATION_NAME + str(i))
    next
        
        
endfunction
    

function LoadResources()
    LoadImage(SPRITE_SHEET_IMAGE_ID, SPRITE_SHEET_FILE_NAME, 1)
    SetImageMagFilter(SPRITE_SHEET_IMAGE_ID, 0)
    
    LoadPlayerAnimations()
    
    
endfunction
    
