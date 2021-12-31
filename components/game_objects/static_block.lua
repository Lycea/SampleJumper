StaticBlock =class_base:extend()


function StaticBlock:new(x,y,width,height)
	self.type = "static"
    self.pos = {}
    self.pos.x = x
    self.pos.y = y
    self.dim = {}
    self.dim.width  = width
    self.dim.height = height
    
    self.moves = false
    self.blocks = true
end

function StaticBlock:draw()
    love.graphics.rectangle("line",self.pos.x,self.pos.y,self.dim.width,self.dim.height)
end


GhostBlock =StaticBlock:extend()
function GhostBlock:new(x,y,width,height)
	self.type = "ghost"
	
    self.pos = {}
    self.pos.x = x
    self.pos.y = y
	
    self.dim = {}
    self.dim.width  = width
    self.dim.height = height
    
    self.moves = false
    self.blocks = false
end

function GhostBlock:draw()
    love.graphics.rectangle("line",self.pos.x,self.pos.y,self.dim.width,self.dim.height)
end






PortBlock =GhostBlock:extend()
function PortBlock:new(x,y,width,height)
	self.type = "port"
	
    self.pos = {}
    self.pos.x = x
    self.pos.y = y
	
    self.dim = {}
    self.dim.width  = width
    self.dim.height = height
    
    self.moves = false
    self.blocks = false
end

function PortBlock:draw()
    love.graphics.rectangle("line",self.pos.x,self.pos.y,self.dim.width,self.dim.height)
end



SpawnBlock =GhostBlock:extend()
function SpawnBlock:new(x,y,width,height)
	self.type = "spawn"
	
    self.pos = {}
    self.pos.x = x
    self.pos.y = y
	
    self.dim = {}
    self.dim.width  = width
    self.dim.height = height
    
    self.moves = false
    self.blocks = false
end

function SpawnBlock:draw()
    love.graphics.rectangle("line",self.pos.x,self.pos.y,self.dim.width,self.dim.height)
end


