
class_base= require("helper.classic")

require("helper.vector")

require("others.globals")

require("others.game_states")
require("others.keyhandler")
require("components.collision_checker")




local game = {}


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


function game.load()
  gravity = vector(0,0.2)
  jump = vector(0,-5)
  right = vector(2,0)
  left = vector(-2,0)
  
  
  ini_player()
  scr_width,scr_height = love.graphics.getDimensions()
  
end


function game.update()
  --check key actions
  
  
  for key,v in pairs(key_list) do
    local action=handle_keys(key)--get key callbacks
    if action["move"] then
        print(action["move"])
        player.vel:add(action["move"])
    end
    if action["jump"] and is_on_ground(player)==true then
        player.vel:add(action["jump"])
    end
  end

  
  update_player()
end


function game.draw()
  love.graphics.rectangle("fill",player.pos.x,player.pos.y,32,32)
end


function game.keyHandle(key,code,r,pressed_)

    
    
    
    --real handling...
    if pressed_ == true then
        key_list[key] = true
        last_key=key
    else
        key_list[key] = nil
    end
end

return game