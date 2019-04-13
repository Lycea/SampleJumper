game = require("game")

local objects = {}
local player ={}
local gravity 

local scr_width
local scr_height
------------------------------------------------
------------------------------------------------




function love.load()
  love.keyboard.setKeyRepeat(false)
  scr_width,scr_height = love.graphics.getDimensions()
  
  game.load()
end


function love.update()
  game.update()
end


function love.draw()
  game.draw()
end


function love.keypressed(k,s,r)
  game.keyHandle(k,s,r,true)
  if key == "escape" then
    love.event.quit()
  end
  
end

function love.keyreleased(k)
    game.keyHandle(k,0,0,false)
end

function love.mousepressed(x,y,btn,t)
  --game.MouseHandle(x,y,btn,t)
end

function love.mousemoved(x,y,dx,dy)
    --game.MouseMoved(x,y)
end

