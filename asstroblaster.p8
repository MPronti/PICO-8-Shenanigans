pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
function _init()

-- save data
 cartdata("pronti_asstroblaster")

-- position
 px = 60
 py = 60

-- acceleration
 pdx = 0
 pdy = 0
 
-- animation
 panim   = 1
 n       = 0
 canmove = true
 
-- speed
 sp = 0.5
 
-- usable colors
 colors = { 1, 2, 3, 4, 5, 6, 
 7, 8, 9, 10, 11, 12, 13, 14,
 15 }
 
-- asteroids table
 asteroids = {
  {x = flr(rnd(124)), 
   y = flr(rnd(124)),
   c = rnd(colors)
  }
 }
 
-- more asteroids
 for i = 1, 19 do
  add(asteroids, {
   x = flr(rnd(124)),
   y = flr(rnd(124)),
   c = rnd(colors)
  })
 end
 
-- score
 score = 0
 
-- timer
 endgame = false
 tl      = 20
 
end

function _update()

--end game
	t = time()
	if (t == tl) endgame = true

-- arrow keys
 if (btn( 0 )) pdx -= sp
 if (btn( 1 )) pdx += sp
 if (btn( 2 )) pdy -= sp
 if (btn( 3 )) pdy += sp
 if (btn( 5 )) dset(0, 0)
 
-- acceleration
 px  += pdx
 py  += pdy
 
 pdx *= 0.85
 pdy *= 0.85
 
-- bounds
 if (px < 0  ) px = 0
 if (px > 120) px = 120
	if (py < 0  ) py = 0
	if (py > 120) py = 120
	
--	animation
	n += 1
	if n%15 == 0 then
	 panim += 1
	 if (panim > 2) panim = 1
	end
	
--	collisions
 if canmove then
	 for l in all(asteroids) do
	 	d = sqrt((px - l.x)^2 + (py - l.y)^2)
	 	if (d < 6) then
	 		l.x = flr(rnd(124))
	 		l.y = flr(rnd(124))
	 		l.c = rnd(colors)
	 		score += 1
	 		sfx(0)
	 	end
	 end
 end

end

-- global variables
mess = "high score:"
halt = false

function _draw()

-- spawn asteroids
	cls(0)
 for l in all(asteroids) do
 	circfill(l.x, l.y, 2, l.c)
 end
 
-- spawn player
 spr(panim, px, py) 
 
-- text
 print("score:"..score, 0, 0, 7)
 print(flr((tl + 1) - t), 0, 6, 7)
 
-- game over
 if endgame then
 	cls(0)
 	canmove = false
 	print("game over!", 0, 0, 7)
 	print("score:"..score, 0, 6, 7)
  if (score > dget(0)) then
   dset(0, score)
   mess  = "new high score:"
   halt = true
  end
 	print(mess..dget(0), 0, 12, 7)
 	end

end
__gfx__
00000000000cc000000cc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000006666000066660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700666666666666666600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000666666666666666600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000666666666666666600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700006666000066660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000bb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000b00b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
0001000029050280502705026050240502305022050200501e0501c05017050100500705000050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
