
class_base= require("helper.classic")

require("helper.vector")

require("others.globals")

require("others.game_states")
require("others.keyhandler")
require("components.collision_checker")

require("game_objects.static_block")



local game = {}


------------------------------------------------
------------------------------------------------

function ini_player()
    player.pos = vector(0)
    player.vel = vector(0)
    player.acc = vector(0)
    player.dim = {width = 32,height = 32}
    
    player.vel:add(gravity)
end
function slow_player()
    local slow_perc = 0.01
    table.insert(string_list_distances,"Player speed x: "..player.vel.x)
    table.insert(string_list_distances,"Player speed_vec: "..player.vel:length())
    
    if math.floor( math.abs(player.vel.x*slow_perc)) == 0 then
        player.vel.x = 0
    else
        player.vel.x = math.floor(player.vel.x*slow_perc)
    end
end

function update_player()
   local max_x = 10
   local max_y = 10
  
    if player.vel.x > max_x then
      player.vel.x = max_x
      --print("Length after adjustation:"..player.vel:length())
    end
    
    if player.vel.y > max_y then
      player.vel.y = max_y
    end
    
    
    player.pos:add(player.vel)
    --local location_object =is_on_object(player)
    handle_collisions(player)
    
    if player.vel.y ~=0 or no_gravity == false then
       player.vel:add(gravity)
    end
    if player.vel.x ~= 0 or no_gravity == false then
        slow_player()
    end
    --print("Pos y:"..player.pos.y)
    
    --print(player.vel:length())
    if dash_used == true then
      if dash_timer + dash_time <= love.timer.getTime() then
        no_gravity = false
      end
    end
    
    
end


function game.load()
  gravity = vector(0,0.3)
  jump = vector(0,-7)
  right = vector(0.3,0)
  left = vector(-0.3,0)
  

  
  ini_player()
  scr_width,scr_height = love.graphics.getDimensions()
  
  --init a test object for now
  
  table.insert(objects,StaticBlock(32*5,scr_height-100,100,100))
  table.insert(objects,StaticBlock(0,scr_height,scr_width,10* player.dim.height))
  
end


function game.update()
  --check key actions
  string_list_distances ={}
  
  for key,v in pairs(key_list) do
    local action=handle_keys(key)--get key callbacks
    
    --editor actions ... don't mind this
    if action["start_edit"] then
        game_state = GameStates.EDITOR
    end
    if action["stop_edit"] then
        game_state = GameStates.PLAYER_ALIVE
    end
    
    
    
    if action["move"] then
        --print(action["move"])
        player.vel:add(action["move"])
    end

    
    if action["jump"] and is_on_object(player) then
        player.vel:add(action["jump"])
    end
    
    if action["dash"]  then
      table.insert(string_list_distances,"tried dash")
      if dash_used == false then
        table.insert(string_list_distances,"dashed")
        no_gravity = true
      
        if key_list["left"] then
          player.vel:add(vector(-vel_dash,0))
        elseif key_list["right"] then
          player.vel:add(vector(vel_dash,0))
        end
        if key_list["up"] then
          player.vel:add(vector(0,-vel_dash))
        elseif key_list["down"] then
          player.vel:add(vector(0,vel_dash))
        end
        dash_used = true
      end
      
    end
  end
  
  --editor mouse events ...
  if mouse_event and game_state == GameStates.EDITOR then
      print(mouse_event.key)
      if mouse_event.key == 1 then --clicked
        if selected_point == false then
            selected_point = true
            first_point.x = mouse_event.x
            first_point.y = mouse_event.y
        else
            selected_point = false
            table.insert(objects,StaticBlock(first_point.x,first_point.y,mouse_event.x-first_point.x,mouse_event.y-first_point.y))
        end
        
      end
      
      
      mouse_event = nil
  end
  
  
  update_player()
  mouse_event = nil
end


function game.draw()
    for idx,object in pairs(objects) do
        object:draw()
    end
    
    
  love.graphics.rectangle("fill",player.pos.x,player.pos.y,32,32)
  
  if game_state == GameStates.EDITOR then
    if selected_point == true then
       love.graphics.rectangle("line",first_point.x,first_point.y, love.mouse.getX()-first_point.x,love.mouse.getY()-first_point.y)
    end
  end
  
  
  love.graphics.print(table.concat(string_list_distances,"\n"),0,0)
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


function game.MouseHandle(x,y,key,t)
    mouse_event = {x=x,y=y,key=key,t=t}
end

function game.MouseMoved(x,y)
    
end


return game