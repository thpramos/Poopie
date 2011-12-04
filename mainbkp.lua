-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

display.setStatusBar( display.HiddenStatusBar )

local backgroundSound = audio.loadStream("hiphop.mp3")
-- audio.play(backgroundSound,{channel=1,loops=-1,fadein=1000})

-- require controller module
local storyboard = require "storyboard"
local widget = require "widget"

-- load first screen
storyboard.gotoScene( "scene1" )


-- Display objects added below will not respond to storyboard transitions



--[[ Uncomment to monitor app's lua memory/texture memory usage in terminal...

local function garbagePrinting()
	collectgarbage("collect")
    local memUsage_str = string.format( "memUsage = %.3f KB", collectgarbage( "count" ) )
    print( memUsage_str )
    local texMemUsage_str = system.getInfo( "textureMemoryUsed" )
    texMemUsage_str = texMemUsage_str/1000
    texMemUsage_str = string.format( "texMemUsage = %.3f MB", texMemUsage_str )
    print( texMemUsage_str )
end

Runtime:addEventListener( "enterFrame", garbagePrinting )
--]]