function love.load()
   wheight = love.graphics.getHeight()
   wwidth = love.graphics.getWidth()

   font = love.graphics.newFont(40)
   love.graphics.setFont(font)

   bounce = love.audio.newSource("bounce.ogg", "static")
   score = love.audio.newSource("score.ogg", "static")
   pausing = love.audio.newSource("pausing.ogg", "static")
   pause = love.audio.newSource("pause.ogg")
   menu = love.audio.newSource("menu.ogg")

   game_pause = false
   show_menu = true
   pw = 10
   ph = 40

   p1x = pw * 5
   p1y = wheight / 2
   p1fx = p1x + pw
   p1direction = 0
   
   p2x = wwidth - pw * 6
   p2y = wheight / 2
   p2fx = p2x + pw
   p2direction = 0

   bx = wwidth / 2
   by = wheight / 2
   br = 10
   
   acc = 2
   acc_factor = 0.2
   xdirection = acc
   ydirection = 0
   bacc = acc

   p1score = 0
   p2score = 0
end

function love.keypressed(key, unicode)
   if key == "return" then
      show_menu = false
      love.audio.stop(menu)
   end
   if key == "escape" then
      love.event.push("quit")
   end
   if key == " " then
      game_paused = not game_paused
      love.audio.play(pausing)
      if game_paused then
	 love.audio.play(pause)
      else
	 love.audio.stop(pause)
      end
   end
end

function love.update(dt)
   if show_menu then return end
   if game_paused then return end
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
   if p1fx > (bx - br) and p1x < (bx - br) and p1y < (by + br) and (p1y + ph) > (by - br) then
      bacc = bacc + acc_factor
      xdirection = bacc
      ydirection = math.random(0, bacc) * p1direction
      love.audio.play(bounce)
   end
   if (bx + br) > p2x and p2fx > (bx + br) and p2y < (by + br) and (p2y + ph) > (by - br) then
      bacc = bacc + acc_factor
      xdirection = -bacc
      ydirection = math.random(0, bacc) * p2direction
      love.audio.play(bounce)
   end
   if (by - br) < 0 or (by + br) > wheight then
      ydirection = -ydirection
      love.audio.play(bounce)
   end
   if (bx - br) < 0 then
      p2score = p2score + 1
      love.audio.play(score)
      reset_ball()
   end
   if (bx + br) > wwidth then
      p1score = p1score + 1
      love.audio.play(score)
      reset_ball()
   end
   bx = bx + xdirection
   by = by + ydirection
end

function love.draw()
   if show_menu then 
      love.graphics.print("Press enter to start game", 140, wheight/2)
      love.audio.play(menu)
      return
   end
   if game_paused then
      love.graphics.print("GAME PAUSED", wwidth/2-130, wheight/2)
   end
   draw_score_board()
   draw_net()
   love.graphics.rectangle("fill", p1x, p1y, pw, ph)
   love.graphics.rectangle("fill", p2x, p2y, pw, ph)
   love.graphics.circle("fill", bx, by, br, 5)
end

function draw_net()
   segments = wheight / 20
   for i=0,segments do
         love.graphics.line(wwidth/2, 30*i, wwidth/2, 30*i+20)
   end
end

function draw_score_board()
   love.graphics.print(p1score, wwidth / 2 - 100, 10)
   love.graphics.print(p2score, wwidth / 2 + 60, 10)
end

function reset_ball()
   bacc = acc
   bx = wwidth / 2
   by = wheight / 2
   xdirection = -xdirection
   ydirection = math.random(-bacc, bacc)
end
