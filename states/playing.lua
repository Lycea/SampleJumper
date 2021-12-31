
local Playing = class_base:extend()

local function ini_player()
    player.pos = vector(0)
    player.vel = vector(0)
    player.acc = vector(0)
    player.dim = {width = 32,height = 32}
    
    player.vel:add(gravity)
end
local function slow_player()
    local slow_perc = 0.01
    table.insert(string_list_distances,"Player speed x: "..player.vel.x)
    table.insert(string_list_distances,"Player speed_vec: "..player.vel:length())
    
    if math.floor( math.abs(player.vel.x*slow_perc)) == 0 then
        player.vel.x = 0
    else
        player.vel.x = math.floor(player.vel.x*slow_perc)
    end
end

local function update_player()
   local max_x = 10
   local max_y = 10
  
  
    player.vel.x = math.max(math.min(player.vel.x,10),-10)
    --if player.vel.x > max_x then
    --  player.vel.x = max_x
      --print("Length after adjustation:"..player.vel:length())
    --end
    
    player.vel.y = math.max(math.min(player.vel.y,10),-10)
    
    if player.vel.y > max_y then
      player.vel.y = max_y
    end
    
    
    player.pos:add(player.vel)
    --local location_object =is_on_object(player)
    handle_collisions(player)
    
    if player.vel.y ~=0 or no_gravity == false then
       player.vel:add(gravity)
    end
    if player.vel.x ~= 0 and no_gravity == false then
        slow_player()
    end
    --print("Pos y:"..player.pos.y)
    
    --print(player.vel:length())
    if dash_used == true then
		print(dash_timer + dash_time,love.timer.getTime())
      if dash_timer + dash_time <= love.timer.getTime() then
        dash_lines[#dash_lines].stop ={x=player.pos.x,y=player.pos.y}
        no_gravity = false
        dash_used = false
        function dash_stop()
			print("?")
        end
        
        dash_stop()
      end
    end
    
    
end

write_data = false
local function hook_start(event,line)
	
  local info = debug.getinfo(2)
  local name =info.name
  
  if event == "call" then
  
    if name == "dash_start" then
      write_data = true
    end
    
    if name == "dash_stop" then
      write_data = false
    end
  end
  
  if  write_data == false or not line  then
    return
  end
  name = info.name or "nan"
  file =io.open("test.txt","a")
  
  file:write(line.." "..name.." "..player.vel.x.." "..info.source.."\n")
  file:close()
  
end



function Playing:new()
	
end


function Playing:load()
  gravity = vector(0,0.3)
  jump = vector(0,-7)
  right = vector(0.3,0)
  left = vector(-0.3,0)
  
  --debug.sethook(hook_start,"cl")
  
  self:ini_player()
  scr_width,scr_height = love.graphics.getDimensions()
  
  --init a test object for now
  
  table.insert(objects,StaticBlock(32*5,scr_height-100,100,100))
  table.insert(objects,StaticBlock(0,scr_height,scr_width,10* player.dim.height))
  
end


function Playing:handle_action(action)
--check key actions
  string_list_distances ={}
  

    
    
    --editor actions ... don't mind this
    if action["start_edit"] then
        game_state = GameStates.EDITOR
    end
    
    
    
    if action["move"] then
        --print(action["move"])
        player.vel:add(action["move"])
    end

    
    if action["jump"] and is_on_object(player) then
        player.vel:add(action["jump"])
    end
    
    if action["dash"]  then
      
      function dash_start()
      
		  table.insert(string_list_distances,"tried dash")
		  if dash_used == false then
			table.insert(string_list_distances,"dashed")
			no_gravity = true
		  
			if key_list["left"] then
			  player.vel.x = -vel_dash
			  player.vel.y = 0
			elseif key_list["right"] then
			  player.vel.x = vel_dash
			  player.vel.y = 0
			end
			
			if key_list["up"] then
			  player.vel.y = -vel_dash
			elseif key_list["down"] then
			  player.vel.y = vel_dash
			end
			table.insert(dash_lines,{start={x=player.pos.x,y=player.pos.y}})
			dash_used = true
			dash_timer = love.timer.getTime()
		  end
	  end
    
      dash_start()
    end


  
  
end

function Playing:update()
	update_player()
end
function Playing:draw()
	for idx,object in pairs(objects) do
        object:draw()
    end

	love.graphics.rectangle("fill",player.pos.x,player.pos.y,32,32)
end

function Playing:mouse()
	
end


function Playing:unload()
	
end

return Playing
