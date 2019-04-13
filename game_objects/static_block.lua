StaticBlock =class_base:extend()


function StaticBlock:new(x,y,width,height)
    self.pos ={}
    self.pos.x = x
    self.pos.y = y
    self.dim={}
    self.dim.width  = width
    self.dim.height = height
    
    self.moves = false
    self.blocks = true
end

function StaticBlock:draw()
    love.graphics.rectangle("line",self.pos.x,self.pos.y,self.dim.width,self.dim.height)
end

