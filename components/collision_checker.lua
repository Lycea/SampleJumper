function is_on_ground(entity)
  if entity.pos.y >= scr_height-32 then
     return true 
  end
  return false
end

--check if x is somewhere on the other block
local function dist_center(a,b)
   return a.pos.x+a.dim.width- (b.pos.x+b.dim.width)
end

local function check_x(a,b)
    --table.insert(string_list_distances,dist_center(a,b))
    if dist_center(a,b)>=a.dim.width/2 then
        return nil
    else
        return true
    end
    
end



function is_on_object(entity)
    --string_list_distances={}
    --table.insert(string_list_distances,entity.dim.width/2)
    
    for idx,object in pairs(objects) do
        if entity.pos.y >= object.pos.y-entity.dim.height  and check_x(entity,object)  then
            return object
        end
    end
end
