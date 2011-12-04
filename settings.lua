---------------------------------------------------------------------------------
--
-- testscreen2.lua
--
---------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

local image, pick_selected, pick1, pick2, pick3, back_btn


function backScene(e)
	if(e.phase == "ended") then
	local soundID = media.newEventSound( "bubble_sound.mp3" )
	media.playEventSound( soundID )
		storyboard.gotoScene( "scene1", "fromLeft", 400  )
	end
end

local function onSceneTouch( self, event )
	if event.phase == "began" then
		
		-- first argument means show native activity indicator while transitioning
		storyboard.gotoScene( true, "scene3", "fromRight", 800  )
		
		return true
	end
end


-- Called when the scene's view does not exist:
function scene:createScene( event )
	local screenGroup = self.view
	image = display.newImage( "settings_bg.png" )
	screenGroup:insert( image )

	back_btn = display.newImageRect("back_btn.png", 33, 30);
	back_btn:setReferencePoint(display.CenterReferencePoint);
	back_btn.x = 20; back_btn.y = 20;
	back_btn.scene = "help";
	screenGroup:insert(back_btn);
	back_btn:addEventListener("touch", backScene);
	
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	
	print( "2: enterScene event" )
	
	-- remove previous scene's view
	storyboard.purgeScene( "scene1" )
	

	-- Update Lua memory text display

end


-- Called when scene is about to move offscreen:
function scene:exitScene()
	
	print( "2: exitScene event" )
	
	
	-- remove touch listener for image
	-- image:removeEventListener( "touch", image )
	-- 
	-- -- reset label text
	-- text2.text = "MemUsage: "
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	
	print( "((destroying scene 2's view))" )
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

---------------------------------------------------------------------------------

return scene