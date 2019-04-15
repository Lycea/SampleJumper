key_list ={
   
 }
 

 
 
 
 key_mapper={
   left = "left",
   right = "right",
   up="up",
   down="down",
   g="pickup",
   i="inventory",
   escape="exit",
   u ="use",
   ["return"] = "select",
   d ="drop",
   x = "dash",
   c = "jump",
   v = "grep",
   e = "edit",
   mt={
     __index=function(table,key) 
      return  "default"
     end
     
     }
   }
 

 


key_list_game={
  jump={jump=jump},
  --down={move="down"},
  left={move=left},
  right={move=right},
  exit = {exit = true},
  edit = {start_edit = true},
  dash = {dash = true },
  default={},
  mt={
     __index=function(table,key) 
      return  {}
     end
     
     }
}


key_list_dead={
    inventory={show_inventory = true},
    exit = {exit = true},
    mt={
     __index=function(table,key) 
      return  {}
     end
     
     }
}

key_list_edit={
    down = {stop_edit= true},
    mt={
     __index=function(table,key) 
      return  {}
     end
     
     }
}

 setmetatable(key_mapper,key_mapper.mt)
 setmetatable(key_list_game,key_list_game.mt)
 setmetatable(key_list_dead,key_list_dead.mt)
 setmetatable(key_list_edit,key_list_edit.mt)
 
 function handle_keys(key)
    local state_caller_list ={
      [GameStates.PLAYER_ALIVE] = key_list_game,
      [GameStates.PLAYER_DEAD] = key_list_dead,
      [GameStates.EDITOR] = key_list_edit
    }

     return state_caller_list[game_state][key_mapper[key]]
end





