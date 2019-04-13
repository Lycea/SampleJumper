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
   c = "grep",
   mt={
     __index=function(table,key) 
      return  "default"
     end
     
     }
   }
 

 


key_list_game={
  up={jump=jump},
  --down={move="down"},
  left={move=left},
  right={move=right},
  exit = {exit = true},
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


 setmetatable(key_mapper,key_mapper.mt)
 setmetatable(key_list_game,key_list_game.mt)
 setmetatable(key_list_dead,key_list_dead.mt)
 
 
 function handle_keys(key)
    local state_caller_list ={
      [GameStates.PLAYER_ALIVE] = key_list_game,
      [GameStates.PLAYER_DEAD] = key_list_dead
    }

     return state_caller_list[game_state][key_mapper[key]]
end