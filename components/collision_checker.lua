function is_on_ground(entity)
  if entity.pos.y >= scr_height-32 then
     return true 
  end
  return false
end