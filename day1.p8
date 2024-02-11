pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
function _init()

 cartdata("day1game_2")

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
 
-- coins
 coins = {
  {x = flr(rnd(126)), 
   y = flr(rnd(126)),
   c = flr(rnd(16))
  }
 }
 
 for i = 1, 20 do
  add(coins, {
   x = flr(rnd(126)),
   y = flr(rnd(126)),
   c = flr(rnd(16))
  })
 end
 
-- score
 score = 0
 
-- timer
 endgame = false
 tl      = 10
 
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
	
--	coin collisions
 if canmove then
	 for l in all( coins ) do
	 	d = sqrt((px - l.x)^2 + (py - l.y)^2)
	 	if (d < 6) then
	 		l.x = flr(rnd(126))
	 		l.y = flr(rnd(126))
	 		l.c = flr(rnd(16))
	 		score += 1
	 	end
	 end
 end

end

mess = "high score:"
dist = 44
halt = false

function _draw()

-- coins
	cls(0)
 for l in all(coins) do
  if (l.y > 12) then
 	 circfill(l.x, l.y, 2, l.c)
 	end
 end
 
-- player
 spr(panim, px, py) 
 
-- text
 print("score: ", 0, 0, 7)
 print(score, 24, 0, 7)
 print(flr((tl + 1) - t), 0, 6, 7)
 
-- game over
 if endgame then
 	cls(0)
 	canmove = false
 	print("game over!", 0, 0, 7)
 	print("score:", 0, 6, 7)
 	print(score, 24, 6, 7)
  if (score > dget(0)) then
   dset(0, score)
   mess  = "new high score:"
   dist += 16
   halt = true
  end
 	print(mess, 0, 12, 7)
  print(dget(0), dist, 12, flr(rnd(16)))
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
