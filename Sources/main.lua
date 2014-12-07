
local Game = require 'Game'

-- Constants

fontNormal = love.graphics.newFont("assets/East-Coast-Stationery.ttf", 32)
fontBig = love.graphics.newFont("assets/East-Coast-Stationery.ttf", 64)
fontTiny = love.graphics.newFont("assets/East-Coast-Stationery.ttf", 16)
love.graphics.setFont(fontNormal)

endScreen = love.graphics.newImage("assets/endScreen.png")

lighterGrey = {220,220,220,255}
lightGrey = {190,190,190,255}
mediumGrey = {120,120,120,255}
darkGrey = {65,65,65,255}
darkerGrey = {30,30,30,255}
white = {255,255,255,255}
black = {0,0,0,255}

LevelBase = require 'LevelBase'

-- Sounds
squeak = love.audio.newSource("assets/squeak.wav", "static")
squeak:setVolume(0.6)
orbTaken = love.audio.newSource("assets/orbTaken.ogg", "static")
squeak:setVolume(0.6)

-- Music
musicPiano = love.audio.newSource("assets/Curtains-piano-garvois.wav")
musicPiano:setLooping(true)

mute = false
keyboardInput = {}
inDialog = false
onEndScreen = false


function love.load()
	love.window.setMode(800, 600)
	love.window.setTitle("Complemental Doors")
	love.graphics.setBackgroundColor(lighterGrey)

	math.randomseed(os.time())

	game = Game.new()
end

function love.update(dt)
	if not inDialog then
		game:update(dt)
		if game.nbOrbs == 7 then
			inDialog = true
			onEndScreen = true
		end
	end
end

function love.draw()
	game:draw()
	love.graphics.setFont(fontTiny)
	love.graphics.setColor(white)
	love.graphics.print("M to Mute",720, 570)
	love.graphics.setFont(fontNormal)
	if onEndScreen then
		love.graphics.setColor(255,255,255,255)
		love.graphics.draw(endScreen, 0, 0)
	end
end

function love.keypressed( key, isrepeat )
	keyboardInput[key] = true
	if key == "m" then
		if mute then
			mute = false
			if game.nbOrbs >= 1 then
				musicPiano:play()
			end
		else
			mute = true
			if game.nbOrbs >= 1 then
				musicPiano:stop()
			end
		end
	end
end

function love.keyreleased( key )
	keyboardInput[key] = false
end

function collision(x1,y1,w1,h1,x2,y2,w2,h2)
    if x2 >= x1 + w1 or x2 + w2 <= x1 or y2 >= y1 + h1 or y2 + h2 <= y1 then
        return false
    else
        return true
    end
end

function love.mousepressed(x, y, button)
	print(x,y)
end