function love.load()
   pw = 15
   ph = 40

   p1x = 10
   p1y = 10
   p1fx = p1x + pw

   p2x = love.graphics.getWidth() - 30
   p2y = 10
   p2fx = p2x + pw

   bx = love.graphics.getWidth() / 2
   by = love.graphics.getHeight() / 2
   br = 10
   
   acc = 2
   xdirection = acc
   ydirection = 0
   p1score = 0
   p2score = 0
end

function love.keypressed(key, unicode)
   if key == "escape" then
      love.event.push("quit")
   end
--[[
   if key == "down" then
      p1y = p1y + 1
   end
   if key == "up" then
      p1y = p1y - 1
   end
   if unicode > 31 and unicode < 127 then
      text = text .. string.char(unicode)
   end
--]]
end

function love.update(dt)
   if love.keyboard.isDown("s") then
      p1y = p1y + acc
   end
   if love.keyboard.isDown("w") then
      p1y = p1y - acc
   end
   if love.keyboard.isDown("down") then
      p2y = p2y + acc
   end
   if love.keyboard.isDown("up") then
      p2y = p2y - acc
   end
   move_ball()
end

function move_ball()
   if p1fx > (bx - br) and p1x < (bx - br)
      and p1y < (by + br) and (p1y + ph) > (by - br) then
      xdirection = -acc
      ydirection = math.random(-acc, acc)
   end
   if (bx + br) > p2x and p2fx > (bx + br)
      and p2y < (by + br) and (p2y + ph) > (by - br) then
      xdirection = acc
      ydirection = math.random(-acc, acc)
   end
   -- if math.abs(p1x - bx) < pw and math.abs(p1y - by) < ph then
   --    xdirection = -acc
   --    ydirection = math.random(-acc, acc)
   -- end
   -- if math.abs(p2x - bx) < pw and math.abs(p2y - by) < ph then
   --    xdirection = acc
   --    ydirection = math.random(-acc, acc)
   -- end
   if by < 5 or math.abs(by - love.graphics.getHeight()) < 5 then
      ydirection = -ydirection
   end
   if bx < 0 then
      p2score = p2score + 1
      bx = love.graphics.getWidth() / 2
      xdirection = -xdirection
   end
   if bx > love.graphics.getWidth() then
      p1score = p1score + 1
      bx = love.graphics.getWidth() / 2
      xdirection = -xdirection
   end
   bx = bx - xdirection
   by = by - ydirection
end

function love.draw()
   --love.graphics.printf(text, 0, 0, 800)
   love.graphics.print(p1score, 50, 10)
   love.graphics.print(p2score, love.graphics.getWidth() - 50, 10)
   love.graphics.rectangle("fill", p1x, p1y, pw, ph)
   love.graphics.rectangle("fill", p2x, p2y, pw, ph)
   love.graphics.circle("fill", bx, by, br, 10)
end
