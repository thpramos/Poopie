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

local function onSceneTouch( self, event )
	if event.phase == "began" then
		
		-- first argument means show native activity indicator while transitioning
		storyboard.gotoScene( true, "scene3", "fromRight", 800  )
		
		return true
	end
end



local function backScene(e)
	if(e.phase == "ended") then
		local soundID = media.newEventSound( "bubble_sound.mp3" )
		media.playEventSound( soundID )
		storyboard.gotoScene( "pick", "fromLeft", 400  )
		
	end
	
end

local function goToGame(e)
	if(e.phase == "ended") then
		local soundID = media.newEventSound( "bubble_sound.mp3" )
		media.playEventSound( soundID )
		-- first argument means show native activity indicator while transitioning
		storyboard.gotoScene("game", "fromRight", 400  )
		
	end
end


-- Called when the scene's view does not exist:
function scene:createScene( event )
	local screenGroup = self.view
	image = display.newImage( "pit.png" )
	screenGroup:insert( image )

	pit_point1 = display.newImageRect("pit_point.png", 23, 23);
	pit_point1:setReferencePoint(display.CenterReferencePoint);
	pit_point1.x = 115; pit_point1.y = 45;
	screenGroup:insert(pit_point1);
	pit_point1:addEventListener("touch", goToGame);

	pit_point2 = display.newImageRect("pit_point.png", 23, 23);
	pit_point2:setReferencePoint(display.CenterReferencePoint);
	pit_point2.x = 199; pit_point2.y = 177;
	screenGroup:insert(pit_point2);
	pit_point2:addEventListener("touch", goToGame);

	pit_point3 = display.newImageRect("pit_point.png", 23, 23);
	pit_point3:setReferencePoint(display.CenterReferencePoint);
	pit_point3.x = 170; pit_point3.y = 251;
	screenGroup:insert(pit_point3);
	pit_point3:addEventListener("touch", goToGame);
	
	pit_point4 = display.newImageRect("pit_point.png", 23, 23);
	pit_point4:setReferencePoint(display.CenterReferencePoint);
	pit_point4.x = 323; pit_point4.y = 162;
	screenGroup:insert(pit_point4);
	pit_point4:addEventListener("touch", goToGame);

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
	storyboard.purgeScene( "pick" )
	

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