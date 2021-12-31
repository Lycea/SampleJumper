
local Editor = class_base:extend()






function Editor:new()
	
end


function Editor:load()
  
end


function Editor:handle_action(action)
 if action["stop_edit"] then
        game_state = GameStates.PLAYER_ALIVE
 end
  
end

function Editor:update()

end
function Editor:draw()
  for idx,object in pairs(objects) do
        object:draw()
  end

  love.graphics.rectangle("fill",player.pos.x,player.pos.y,32,32)
	
	
	
  if game_state == GameStates.EDITOR then
    if selected_point == true then
       love.graphics.rectangle("line",first_point.x,first_point.y, love.mouse.getX()-first_point.x,love.mouse.getY()-first_point.y)
    end
  end
end

function Editor:mouse()
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
end


function Editor:unload()
	
end

return Editor