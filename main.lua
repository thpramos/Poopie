---------------------------------------------------------------------------------
--
-- testscreen2.lua
--
---------------------------------------------------------------------------------

--local storyboard = require( "storyboard" )
--local scene = storyboard.newScene()
local gameSound;
---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

local image, pick_selected, pick1, pick2, pick3, back_btn
local movieclip = require("movieclip")

-- IMPORT THE BUTTONS CLASS
local ui = require("ui")

local bg = display.newImage( "help_bg.png" )


--PASSEI O ENTER SCENE PRA CA PRA RODAR NO MEU CORONA! IGNORAR!!
print( "2: enterScene event" )
	
	gameSound = audio.loadStream("level1.mp3")
	audio.play(gameSound,{channel=2,loops=-1,fadein=5000})




--CREATE TWO GROUPS(LAYERS), SO THE BUTTONS KEEP ON THE FRONT
local background = display.newGroup()
local foreground = display.newGroup()

a = {}    
j = 1

for i=1, 49 do
a[i] = string.format("%s%i%s","f-",1,".png")
end

--IMPLEMENTATION OF THE PIG
x=0
    for i=50, 1700 do
      if (x==13) then
      j = j +1
      x = 0 
      end
      x = x + 1    
      a[i] = string.format("%s%i%s","f-",j,".png")	
end


 	local myAnim = movieclip.newAnim(a)
	background:insert(myAnim)

	myAnim.x = display.contentWidth / 2
	myAnim.y = display.contentHeight / 2

  
	myAnim:play{ startFrame=1, endFrame=1700, loop=1, remove=true }
	
--KNOWN BATITAS 1950 / 3900
-- GAME VARS
local gameStartDelay = 0
local gameEndTime = 59800
local deadRingSize = 130
local ringLife = 800
local score = 0 
local showingRings = {}
local rings = {} -- STORE THE RINGS MAPPING
local scrCenter = { x=display.contentWidth/2, y=display.contentHeight/2}

--SCORE SETUP
local scoreText = display.newText( "SCORE: 0", 0, 0, "Helvetica", 16 )
scoreText.x = display.contentWidth/8*7
background:insert(scoreText)
--scoreText:setTextColor(0, 0, 255)


--DIFFICULT SETUP
local excelentLimit = 50
local goodLimit = 100

--BUTTONS AND RINGS LOCATIONS
local redPos = {x = display.contentWidth / 4 -50, y = 230}
local bluePos = {x = display.contentWidth / 4 *3+50, y = 230}
local greenPos = {x = display.contentWidth / 4 *3+50, y = 90}
local yellowPos = {x = display.contentWidth / 4 -50, y = 90}

--RINGS SETUP
rings[1] ={}
rings[1].Color = "Red"
rings[1].beatMap = {}
rings[1].rate = 1950
rings[1].start = 0
rings[1].finish = 19500

rings[2] ={}
rings[2].Color = "Red"
rings[2].beatMap = {}
rings[2].rate = 1950
rings[2].start = 39000
rings[2].finish = gameEndTime

rings[3] ={}
rings[3].Color = "Green"
rings[3].beatMap = {}
rings[3].rate = 1950
rings[3].start = 19500
rings[3].finish = 39000

rings[4] ={}
rings[4].Color = "Blue"
rings[4].beatMap = {}
rings[4].rate = 3900
rings[4].start = 0
rings[4].finish = gameEndTime


local listener1 = function( obj )
        print( "Transition 1 completed on object: " .. tostring( obj ) )
end

	

--CREATOR OF THE MAP (FOR FAST CONVINIENCE) BEST IS TO SET MANUALLY
for variable,value in pairs(rings) do --VARRE OS RINGS
	for j = value.start,value.finish,value.rate do --VARRE O TEMPO SEGUINDO O RATE
		table.insert(value.beatMap, j) --INSERE NO MAPA
	end
	print(table.concat(value.beatMap," ,")) --IMPRIME PARA CHECAR
end
-- APOS ESSA ETAPA OS BEATMAPS FORAM CRIADOS E INSERIDOS NOS RINGS (ISTO PODERIA SER UMA FUNCAO SENDO CHAMADA EM CADA RING)	


local function checkClick(color,clickTime)
	local nohit = true
	for variable,value in pairs(rings) do --VARRE OS RINGS
		if value.Color == color then --SE A COR CLICADA FOR IGUAL A COR DO RING ATUAL ENTÃO
			
			for v,i in pairs(value.beatMap) do --VARRE O BEAT MAP DE CADA RING
				--EXCELENT CLICK
				if  clickTime > i - excelentLimit and clickTime < i + excelentLimit then
					local nExc = movieclip.newAnim({"Excelent_01.png","Excelent_01.png","Excelent_02.png","Excelent_02.png","Excelent_03.png","Excelent_03.png","Excelent_04.png","Excelent_04.png","Excelent_05.png","Excelent_05.png","Excelent_06.png","Excelent_06.png","Excelent_07.png","Excelent_07.png","Excelent_08.png","Excelent_08.png","Excelent_08.png","Excelent_08.png","Excelent_08.png","Excelent_08.png","Excelent_08.png","Excelent_08.png","Excelent_08.png","Excelent_08.png","Excelent_08.png","Excelent_08.png","Excelent_08.png","Excelent_08.png","Excelent_08.png","Excelent_08.png","Excelent_08.png","Excelent_08.png","Excelent_08.png","Excelent_08.png"})
					background:insert(nExc)
					if color == "Red" then 
						nExc.x = redPos.x
						nExc.y = redPos.y
					elseif color == "Blue" then
						nExc.x = bluePos.x
						nExc.y = bluePos.y
					elseif color == "Green" then
						nExc.x = greenPos.x
						nExc.y = greenPos.y
					elseif color == "Yellow" then
						nExc.x = yellowPos.x
						nExc.y = yellowPos.y
					end
					nExc:play{ startFrame=1, endFrame=16, loop=1, remove=true }
					transition.to( nExc, { time=800, x=scrCenter.x, y=scrCenter.y, onComplete=listener1 } )
					score = score + 2
					nohit = false
				elseif  clickTime > i - goodLimit and clickTime < i + goodLimit then --GOOD CLICK
					local nExc = movieclip.newAnim({"Good_01.png","Good_01.png","Good_02.png","Good_02.png","Good_03.png","Good_03.png","Good_04.png","Good_04.png","Good_05.png","Good_05.png","Good_06.png","Good_06.png","Good_07.png","Good_07.png","Good_08.png","Good_08.png","Good_08.png","Good_08.png","Good_08.png","Good_08.png","Good_08.png","Good_08.png","Good_08.png","Good_08.png","Good_08.png","Good_08.png","Good_08.png","Good_08.png","Good_08.png","Good_08.png","Good_08.png","Good_08.png","Good_08.png","Good_08.png"})
					background:insert(nExc)
					if color == "Red" then 
						nExc.x = redPos.x
						nExc.y = redPos.y
					elseif color == "Blue" then
						nExc.x = bluePos.x
						nExc.y = bluePos.y
					elseif color == "Green" then
						nExc.x = greenPos.x
						nExc.y = greenPos.y
					elseif color == "Yellow" then
						nExc.x = yellowPos.x
						nExc.y = yellowPos.y
					end
					nExc:play{ startFrame=1, endFrame=16, loop=1, remove=true }
					transition.to(nExc, { time=800, x=scrCenter.x, y=scrCenter.y, onComplete=listener1 } )
					score = score + 1
					nohit = false
				end
			end	
		end
	end
	if nohit then
		local nExc = movieclip.newAnim({"Miss_01.png","Miss_01.png","Miss_02.png","Miss_02.png","Miss_03.png","Miss_03.png","Miss_04.png","Miss_04.png","Miss_05.png","Miss_05.png","Miss_06.png","Miss_06.png","Miss_07.png","Miss_07.png","Miss_08.png","Miss_08.png","Miss_08.png","Miss_08.png","Miss_08.png","Miss_08.png","Miss_08.png","Miss_08.png","Miss_08.png","Miss_08.png","Miss_08.png","Miss_08.png","Miss_08.png","Miss_08.png","Miss_08.png","Miss_08.png","Miss_08.png","Miss_08.png","Miss_08.png","Miss_08.png"})
		background:insert(nExc)
		if color == "Red" then 
			nExc.x = redPos.x
			nExc.y = redPos.y
		elseif color == "Blue" then
			nExc.x = bluePos.x
			nExc.y = bluePos.y
		elseif color == "Green" then
			nExc.x = greenPos.x
			nExc.y = greenPos.y
		elseif color == "Yellow" then
			nExc.x = yellowPos.x
			nExc.y = yellowPos.y
		end
		nExc:play{ startFrame=1, endFrame=16, loop=1, remove=true }
		transition.to(nExc, { time=800, x=scrCenter.x, y=scrCenter.y, onComplete=listener1 } )
		score = score - 1
	end
end

	-- Store button actions in lookup table, for convenience
	local actions = {}
	actions["button1"] = function()  
		checkClick("Red", system.getTimer())
	end
	
	-- Store button actions in lookup table, for convenience
	actions["button2"] = function() 
		checkClick("Blue", system.getTimer())	
	    end
	
	-- Store button actions in lookup table, for convenience
	actions["button3"] = function() 
		checkClick("Yellow", system.getTimer())
	    end
	
	actions["button4"] = function() 
		checkClick("Green", system.getTimer())
	end
	
	
		
	-- General function for all buttons (uses "actions" table above)
	local buttonHandler = function( event )
		if ( "press" == event.phase ) then
			actions[ event.id ]()
		end
	end



-- CREATE THE BUTTONS
	local button1 = ui.newButton{
		default = "buttonRed.png",
		over = "buttonRedPressed.png",
		onEvent = buttonHandler,
		id = "button1",
		size = 10,
		emboss = true,
		x = redPos.x, 
		y = redPos.y
	}
	button1.alpha = 0.8
	foreground:insert( button1 )
	
	local button2 = ui.newButton{
		default = "buttonBlue.png",
		over = "buttonBluePressed.png",
		onEvent = buttonHandler,
		id = "button2",
		size = 18,
		emboss = true,
		x = bluePos.x, 
		y = bluePos.y
	}
	button2.alpha = 0.8
	foreground:insert( button2 )
	
	local button3 = ui.newButton{
		default = "buttonYellow.png",
		over = "buttonYellowPressed.png",
		onEvent = buttonHandler,
		id = "button3",
		size = 18,
		emboss = true,
		x = yellowPos.x, 
		y = yellowPos.y
	}
	button3.alpha = 0.8
	foreground:insert( button3 )
	
	local button4 = ui.newButton{
		default = "buttonGreen.png",
		over = "buttonGreenPressed.png",
		onEvent = buttonHandler,
		id = "button4",
		size = 18,
		emboss = true,
		x = greenPos.x, 
		y = greenPos.y
	}
	button4.alpha = 0.8
	foreground:insert( button4 )


	

	
	
--CREATES THE RINGS
local function showNewRing(Color)
	if Color == "Red" then
		table.insert(showingRings,1, display.newImage("ring1.png"))
		showingRings[1].x = redPos.x
		showingRings[1].y = redPos.y
		showingRings[1].alpha = 0.8
		background:insert(showingRings[1])
	elseif Color =="Blue" then
		table.insert(showingRings,1, display.newImage("blueRing.png"))
		showingRings[1].x = bluePos.x
		showingRings[1].y = bluePos.y
		showingRings[1].alpha = 0.8
		background:insert(showingRings[1])
	elseif Color == "Green" then
		table.insert(showingRings,1, display.newImage("greenRing.png"))
		showingRings[1].x = greenPos.x
		showingRings[1].y = greenPos.y
		showingRings[1].alpha = 0.8
		background:insert(showingRings[1])
	elseif Color == "Yellow" then
		table.insert(showingRings,1, display.newImage("yellowRing.png"))
		showingRings[1].x = yellowPos.x
		showingRings[1].y = yellowPos.y
		showingRings[1].alpha = 0.8
		background:insert(showingRings[1])
	end
end


-- A per-frame event to move the elements
local tPrevious = system.getTimer()
local tPreviousRedRing = system.getTimer()
local tPreviousBlueRing = tPreviousRedRing
	

local function move(event)
	local tDelta = event.time - tPrevious
	
	
	--CHECK FOR END
	if  (event.time > 59800) then	
		audio.stop(backgroundSound,{channel=1,loops=-1,fadein=1000})
	end
	
	
	--CHECK THE MAPS TO FIND RINGS TO CREATE
	for variable,value in pairs(rings) do --VARRE OS RINGS
		for v,i in pairs(value.beatMap) do --VARRE O BEAT MAP DE CADA RING
			if i > (tPrevious+ringLife) and i < (event.time+ringLife) then --SE A BATIDA TA ENTRE O (LOOP ANTERIOR + TEMPO DE VIDA) E (ESTE + TEMPO DE VIDA) E RODE
				showNewRing(value.Color)
			end
		end
	end
	
	-- UPDATE THE RINGS SIZE, IF ITS SMALLER THAN THE BUTTON, IT IS REMOVED
	-- TEM QUE REMOVER DE TRAS PRA FRENTE PORQUE SENÃO A TABLE.REMOVE ATRAPALHA ESSE FOR
	for i=table.getn(showingRings),1,-1 do
		local sxy = 1-((130/ringLife*tDelta)/showingRings[i].contentHeight)
		showingRings[i]:scale(sxy,sxy)
		if showingRings[i].contentHeight < 130 then
			showingRings[i]:removeSelf()
			table.remove(showingRings,i)		
		end
	end
	tPrevious = event.time
	scoreText.text = string.format("%s%i","SCORE: ",score)
end


-- Start everything moving
Runtime:addEventListener( "enterFrame", move );