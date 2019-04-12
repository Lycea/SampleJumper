vector = class_base:extend()

function vector:new(x,y)
  self.x = x
  self.y = y or 0
end


function vector:add(vector)
  self.x = self.x +vector.x
  self.y = self.y +vector.y or 0
end


function vector:sub(vector)
  self.x = self.x -vector.x
  self.y = self.y -vector.y or 0
end

function vector:multi(vector)
  self.x = self.x *vector.x
  self.y = self.y *vector.y or 0
end

function vector:div(vector)
  self.x = self.x /vector.x
  self.y = self.y /vector.y or 0
end

function vector:heading()
  return math.atan2(self.y,self.x)
end

function vector:length()
  return math.sqrt(self.x^2+self.y^2)
end

function vector:setLength(length)
  --print("vector pre norm:"..self:length())
  self:normalize()
  --print("vector after norm:"..self:length())
  self:multi(vector(length,length))
end

function vector:normalize()
  local tmp =vector(self:length(),self:length())
  self:div(tmp)
end

function vector:fromAngle(angle)
  self.x = math.sin(angle)
  self.y = math.cos(angle)
end
