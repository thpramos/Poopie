---------------------------------------------------------------------------------
--
-- testscreen1.lua
--
---------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

local image, text1, text2, text3, btn1, btn2, btn3, settings, news


-- Touch event listener for background image
local function onSceneTouch( self, event )
	if event.phase == "began" then
		
	--storyboard.gotoScene( "scene2", "fade", 400  )
		
		return true
	end
end

function changeScene(e)
	if(e.phase == "ended") then
		local soundID = media.newEventSound( "bubble_sound.mp3" )
		media.playEventSound( soundID )
		-- local backgroundSound = audio.loadStream("button_sound_4.mp3")
		-- audio.play(backgroundSound,{channel=1,loops=0,fadein=1000})
		storyboard.gotoScene( e.target.scene, "fromRight", 400  )
		
	end
	
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local screenGroup = self.view
	
	image = display.newImage( "bg.png" )
	screenGroup:insert( image )
	
	btn1 = display.newImageRect("btn1.png", 240, 60);
	btn1:setReferencePoint(display.CenterReferencePoint);
	btn1.x = 130; btn1.y = 160;
	btn1.scene = "pick";

	btn2 = display.newImageRect("btn2.png", 240, 60);
	btn2:setReferencePoint(display.CenterReferencePoint);
	btn2.x = 130; btn2.y = 220;
	btn2.scene = "about";
	
	btn3 = display.newImageRect("btn3.png", 240, 60);
	btn3:setReferencePoint(display.CenterReferencePoint);
	btn3.x = 130; btn3.y = 280;
	btn3.scene = "help";

	screenGroup:insert(btn1);
	screenGroup:insert(btn2);
	screenGroup:insert(btn3);
	
	-- btn1.touch = onSceneTouch
	-- btn2.touch = onSceneTouch
	-- btn3.touch = onSceneTouch
	
	btn1:addEventListener("touch", changeScene);
	btn2:addEventListener("touch", changeScene);
	btn3:addEventListener("touch", changeScene);
	
	
	settings = display.newImageRect("settings_btn.png", 97, 18);
	settings:setReferencePoint(display.CenterReferencePoint);
	settings.x = 385; settings.y = 15;
	settings.scene = "settings";
	
	news = display.newImageRect("news_btn.png", 61, 18);
	news:setReferencePoint(display.CenterReferencePoint);
	news.x = 280; news.y = 15;
	news.scene = "news";
	
	screenGroup:insert(settings);
	screenGroup:insert(news);
	settings:addEventListener("touch", changeScene);
	news:addEventListener("touch", changeScene);
	
	-- 
	
	
	-- text1 = display.newText( "Scene 1", 0, 0, native.systemFontBold, 24 )
	-- text1:setTextColor( 255 )
	-- text1:setReferencePoint( display.CenterReferencePoint )
	-- text1.x, text1.y = display.contentWidth * 0.5, 50
	-- screenGroup:insert( text1 )
	-- 
	-- text2 = display.newText( "MemUsage: ", 0, 0, native.systemFont, 16 )
	-- text2:setTextColor( 255 )
	-- text2:setReferencePoint( display.CenterReferencePoint )
	-- text2.x, text2.y = display.contentWidth * 0.5, display.contentHeight * 0.5
	-- screenGroup:insert( text2 )
	-- 
	-- text3 = display.newText( "Touch to continue.", 0, 0, native.systemFontBold, 18 )
	-- text3:setTextColor( 255 ); text3.isVisible = false
	-- text3:setReferencePoint( display.CenterReferencePoint )
	-- text3.x, text3.y = display.contentWidth * 0.5, display.contentHeight - 100
	-- screenGroup:insert( text3 )
	
	print( "\n1: createScene event")
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local backgroundSound = audio.loadStream("hiphop.mp3")
	audio.play(backgroundSound,{channel=1,loops=-1,fadein=1000})
	print( "1: enterScene event" )
	
	-- remove previous scene's view
--	storyboard.purgeScene( "scene4" )
	
	-- Update Lua memory text display
	-- local showMem = function()
	-- 	image:addEventListener( "touch", image )
	-- 	text3.isVisible = true
	-- 	text2.text = text2.text .. collectgarbage("count")/1000 .. "MB"
	-- 	text2.x = display.contentWidth * 0.5
	-- end
	-- local memTimer = timer.performWithDelay( 1000, showMem, 1 )
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	
	print( "1: exitScene event" )
	
	-- remove touch listener for image
	image:removeEventListener( "touch", image )
	
	-- reset label text
	-- text2.text = "MemUsage: "
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	
	print( "((destroying scene 1's view))" )
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