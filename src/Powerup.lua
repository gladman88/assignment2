--[[
    GD50
    Breakout Remake

    -- Ball Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Represents a ball which will bounce back and forth between the sides
    of the world space, the player's paddle, and the bricks laid out above
    the paddle. The ball can have a skin, which is chosen at random, just
    for visual variety.
]]

Powerup = Class{}

function Powerup:init(skin)
    -- simple positional and dimensional variables
    self.width = 16
    self.height = 16
    
	-- x is placed randomly
    self.x = math.random(self.width, VIRTUAL_WIDTH - self.width)

    -- y is placed randomly between 
    self.y = VIRTUAL_HEIGHT / 2 + math.random(40)
    
    -- it's must falling dawn
    self.dy = 50
    self.dx = 0
    
    self.skin = skin
    -- kinds of powerups: ball, key
    self.kind = 'ball' 
    
    -- we will show it only if we got some amounts of hits
    self.show = false
end

function Powerup:reset()
	-- x is placed randomly
    self.x = math.random(self.width, VIRTUAL_WIDTH - self.width)

    -- y is placed randomly between 
    self.y = VIRTUAL_HEIGHT / 2 + math.random(40)
    
    -- hide it
    self.show = false
    
    self.skin = math.random(9)
    self.kind = 'ball' 
end

--[[
    Expects an argument with a bounding box, be that a paddle or a brick,
    and returns true if the bounding boxes of this and the argument overlap.
]]
function Powerup:collides(target)
    -- first, check to see if the left edge of either is farther to the right
    -- than the right edge of the other
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end

    -- then check to see if the bottom edge of either is higher than the top
    -- edge of the other
    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end 

    -- if the above aren't true, they're overlapping
    return true
end

function Powerup:update(dt)
    self.y = self.y + self.dy * dt
end

function Powerup:render()
    -- gTexture is our global texture for all blocks
    -- gBallFrames is a table of quads mapping to each individual ball skin in the texture
    love.graphics.draw(gTextures['main'], gFrames['powerups'][self.skin],
        self.x, self.y)
end