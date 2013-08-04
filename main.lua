function love.load()
   wheight = love.graphics.getHeight()
   wwidth = love.graphics.getWidth()
   pw = 15
   ph = 40

   p1x = 10
   p1y = 10
   p1fx = p1x + pw
   p1direction = 0
   
   p2x = wwidth - 30
   p2y = 10
   p2fx = p2x + pw
   p2direction = 0

   bx = wwidth / 2
   by = wheight / 2
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
end

function love.update(dt)
   p1direction = 0
   p2direction = 0
   if love.keyboard.isDown("s") and (p1y + ph) < wheight then
      p1y = p1y + acc
      p1direction = -2
   end
   if love.keyboard.isDown("w") and p1y > 0 then
      p1y = p1y - acc
      p1direction = 2
   end
   if love.keyboard.isDown("down") and (p2y + ph) < wheight then
      p2y = p2y + acc
      p2direction = -2
   end
   if love.keyboard.isDown("up") and p2y > 0 then
      p2y = p2y - acc
      p2direction = 2
   end
   move_ball()
end

function move_ball()
   if p1fx > (bx - br) and p1x < (bx - br)
      and p1y < (by + br) and (p1y + ph) > (by - br) then
      xdirection = acc
      ydirection = math.random(0, acc) * p1direction
   end
   if (bx + br) > p2x and p2fx > (bx + br)
      and p2y < (by + br) and (p2y + ph) > (by - br) then
      xdirection = -acc
      ydirection = math.random(0, acc) * p2direction
   end
   if (by - br) < 0 or (by + br) > wheight then
      ydirection = -ydirection
   end
   if (bx - br) < 0 then
      p2score = p2score + 1
      bx = wwidth / 2
      xdirection = -xdirection
   end
   if (bx + br) > wwidth then
      p1score = p1score + 1
      bx = wwidth / 2
      xdirection = -xdirection
   end
   bx = bx + xdirection
   by = by + ydirection
end

function love.draw()
   love.graphics.print(p1score, 50, 10)
   love.graphics.print(p2score, wwidth - 50, 10)
   draw_net()
   love.graphics.rectangle("fill", p1x, p1y, pw, ph)
   love.graphics.rectangle("fill", p2x, p2y, pw, ph)
   love.graphics.circle("fill", bx, by, br, 10)
end

function draw_net()
   segments = wheight / 20
   for i=0,segments do
         love.graphics.line(wwidth/2, 30*i, wwidth/2, 30*i+20)
   end
end
