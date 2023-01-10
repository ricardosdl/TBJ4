
// Project: TBJ4 
// Created: 2022-12-22

// show all errors
SetErrorMode(2)

#include "resources.agc"
#include "constants.agc"
#include "gamestate.agc"
#include "player.agc"

global MainGameState as TGameState

// set window properties
SetWindowTitle( "TBJ4" )
SetWindowSize( WINDOW_WIDTH, WINDOW_HEIGHT, 0 )
SetWindowAllowResize( 1 ) // allow the user to resize the window

// set display properties
SetVirtualResolution( RESOLUTION_WIDTH, RESOLUTION_HEIGHT) // doesn't have to match the window
SetOrientationAllowed( 1, 1, 1, 1 ) // allow both portrait and landscape on mobile devices
SetVSync(1) //turns on vsync, to refresh the game at the screen refreseh rate
SetScissor( 0,0,0,0 ) // use the maximum available screen space, no black borders
UseNewDefaultFonts( 1 ) // since version 2.0.22 we can use nicer default fonts

LoadResources()

GameStateInit(MainGameState)
//InitPlayer(Player)


do
    //Print( ScreenFPS() )
    TimeSlice# = GetFrameTime()
    GameStateUpdate(MainGameState, TimeSlice#)
    DrawBox(MainGameState.GameArea.PosX, MainGameState.GameArea.PosY, MainGameState.GameArea.PosX + MainGameState.GameArea.Width,
    MainGameState.GameArea.PosX + MainGameState.GameArea.Height,
    MakeColor(155, 80, 60), MakeColor(155, 80, 60), MakeColor(155, 80, 60), MakeColor(155, 80, 60),
        0)
    Sync()
loop
