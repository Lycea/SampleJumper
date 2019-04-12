class_base= require("classic")
require("vector")

local objects = {}
local player ={}
local gravity 

local scr_width
local scr_height
------------------------------------------------
------------------------------------------------

function ini_player()
    player.pos = vector(0)
    player.vel = vector(0)
    player.acc = vector(0)
end
function slow_player()
    player.vel.x = player.vel.x-(player.vel.x/10)
end

function update_player()
   
    if player.vel:length() > 25 then
      player.vel:setLength(50)
      --print("Length after adjustation:"..player.vel:length())
    end
    
    player.pos:add(player.vel)
    if player.pos.y >= scr_height-32 then
      player.pos.y = scr_height-32
      player.vel.y = 0
    else
       player.vel:add(gravity)
    end
    slow_player()
    --print("Pos y:"..player.pos.y)
    
    --print(player.vel:length())
end


function love.load()
  love.keyboard.setKeyRepeat(true)
  gravity = vector(0,0.2)
  ini_player()
  scr_width,scr_height = love.graphics.getDimensions()
  
end


function love.update()
  update_player()
end


function love.draw()
  love.graphics.rectangle("fill",player.pos.x,player.pos.y,32,32)
end


function love.keypressed(key,code)
    jump = vector(0,-5)
    right = vector(2,0)
    left = vector(-2,0)
    
    if key == "up"then
      print("jumped")
      print("vel pre:"..player.vel.y)
      if player.vel.y ==0 then
      
        player.vel:add(jump)
      end
      
      
    end
    if key == "down"then
      
    end
    
    if key == "left"then
      player.vel:add(left)
    end
    if key == "right"then
      player.vel:add(right)
    end
    
end

