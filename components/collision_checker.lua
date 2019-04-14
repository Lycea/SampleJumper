function is_on_ground(entity)
  if entity.pos.y >= scr_height-32 then
     return true 
  end
  return false
end

--check if x is somewhere on the other block
local function dist_center(a,b)
   return (a.pos.x+a.dim.width)-(b.pos.x+b.dim.width)
end
local function angle_between(a,b)
  return math.atan2(a.pos.y -b.pos.y,a.pos.x-b.pos.y)
end

local function check_x(a,b)
    table.insert(string_list_distances,"dist: : "..dist_center(a,b))
    table.insert(string_list_distances,"width: : "..a.dim.width/2)
    local dist = dist_center(a,b)
    if dist>=a.dim.width/2  then
        return nil
    else
        return true
    end
    
end



function is_on_object2(entity)
    string_list_distances={}
    table.insert(string_list_distances,entity.pos.y)
    table.insert(string_list_distances,math.floor(math.deg(entity.pos:heading())))
    
    for idx,object in pairs(objects) do
        table.insert(string_list_distances,"Angle: "..math.deg(angle_between(object,entity)))
        table.insert(string_list_distances,object.pos.y)
        if math.floor(entity.pos.y) >= object.pos.y-entity.dim.height  and check_x(entity,object)  then
            
            table.insert(string_list_distances,object.pos.y)
            
            return object
        end
    end
end



function collides(entity)
    local collision_list ={}
    for idx,object in pairs(objects) do
        if entity.pos.x < object.pos.x + object.dim.width and --check right side
           entity.pos.x+entity.dim.width> object.pos.x    and --check left ?
           entity.pos.y < object.pos.y + object.dim.height and
           entity.pos.y + entity.dim.height > object.pos.y then
               
            table.insert(collision_list,object)
        end
    end
    return collision_list
end

local function get_x_center(obj)
    return obj.dim.width /2 + obj.pos.x
end

local function get_y_center(obj)
    return obj.dim.height /2 + obj.pos.y
end


local function collision_side(a,b)
    local w = 0.5 * (a.dim.width + b.dim.width)
    local h = 0.5 * (a.dim.height + b.dim.height)
    local dx = get_x_center(a) - get_x_center(b)
    local dy = get_y_center(a) - get_y_center(b)
    
    if math.abs(dx) <= w and math.abs(dy)<= h then
        
        local wy = w*dy
        local hx = h*dx
        
        if wy> hx then
            if wy > -hx then
                return "top"
            else
                return "left"
            end
        else
            if wy > -hx  then
                return "right"
            else
                return "bottom"
            end
        end
    end
    
        
    
end

function is_on_object(entity)
    string_list_distances ={}
    --local collision_list = collides(entity)
    for idx,object in pairs(objects) do
       local collides = collision_side(entity,object) 
       
       if collides == "bottom"  then
           return object
       end
    end
    
end



function handle_collisions (entity)
     string_list_distances ={}
    --local collision_list = collides(entity)
    for idx,object in pairs(objects) do
       local collides = collision_side(entity,object) 
       
       if collides then
          if collides == "bottom" then
            entity.pos.y = object.pos.y -entity.dim.height
            entity.vel.y =0
          elseif collides == "top" then
              entity.pos.y = object.pos.y +object.dim.height
          elseif collides == "left" then
              entity.pos.x = object.pos.x-entity.dim.width
              entity.vel.x = 0
          else
              entity.pos.x = object.pos.x+object.dim.width
              entity.vel.x = 0
          end
       end
    end
end

