if not (arg[1] and arg[2] and arg[3] and arg[4] and arg[5]) then
	print('Missing arguments!\n' .. arg[0] .. ' [grid size x + 1] [grid size y + 1] [debug] [ultra hard mode] [ai mode]')
	goto eof
end

if tonumber(arg[5]) == 1 then --not implimented yet
	--load functions from someone elses code
	--dofile('path.lua')
end

function diff(a, b)
	return math.abs(a - b)
end

function drawscreen()
	os.execute('clear')
	print('Steps: ' .. steps .. '\nScore: ' .. score - 3 .. '\nGame board:')
	string = ''
	tmp0 = arg[2] - 1
	for i = 1, arg[2] - 1 do
		tmp1 = arg[1] - 1
		for j = 1, arg[1] - 1 do
			tmp2 = board[tmp0][tmp1]
			if (tmp2 == 0) then
				string = string .. '- '
			elseif (tmp2 > 0) and (tmp2 < score) then
				string = string .. '# '
			elseif (tmp2 == score) then
				string = string .. '% '
			elseif (tmp2 == -1) then
				string = string .. '* '
			else
				string = string .. '? '
			end
			tmp1 = tmp1 - 1
		end
		tmp0 = tmp0 - 1
		string = string .. '\n'
	end
	print(string)
end
function drawdebug()
	print('pY: ' .. playery .. '\npX: ' .. playerx)
	print('aY: ' .. appley .. '\naX: ' .. applex)
	print('Debug board:')
	string = ''
	tmp0 = arg[2]
	for i = 1, arg[2] do
		tmp1 = arg[1]
		for j = 1, arg[1] do
			string = string .. board[tmp0][tmp1]
			tmp1 = tmp1 - 1
		end
		tmp0 = tmp0 - 1
		string = string .. '\n'
	end
	print(string)
end
function apple()
	tmp2 = 1
	oldx = applex + 0 --fuck referencing lol
	oldy = appley + 0
	while tmp2 == 1 do
		applex = math.random(arg[1] - 1)
		appley = math.random(arg[2] - 1)
		if (board[appley][applex] == 0) and (oldx ~= applex) and (oldy ~= appley) then
			tmp2 = 0
		end
	end
	board[appley][applex] = -1
end
function update()
	if pause == 0 then
		tmp0 = arg[2]
		for i = 1, arg[2] do
			tmp1 = arg[1]
			for j = 1, arg[1] do
				tmp2 = board[tmp0][tmp1]
				if (tmp2 > 0) then
					board[tmp0][tmp1] = tmp2 - 1
				end
				tmp1 = tmp1 - 1
			end
			tmp0 = tmp0 - 1
		end
	end
	if tonumber(arg[4]) == 0 then
		pause = 0
	end
	steps = steps + 1
	lives = 500
	board[playery][playerx] = score
end

--init
math.randomseed(os.time())
steps = 0
score = 3
applex = 0
appley = 0
pause = 0
lives = 500
board = {}
tmp0 = arg[2]
for i = 1, arg[2] do
	board[tmp0] = {}
	tmp1 = arg[1]
	for j = 1, arg[1] do
		board[tmp0][tmp1] = 0
		tmp1 = tmp1 - 1
	end
	tmp0 = tmp0 - 1
end
tmp0 = arg[1]
tmp1 = arg[2]
playerx = math.random(tmp0 - 1)
playery = math.random(tmp1 - 1)
board[playery][playerx] = score
apple()

::bos:: 
drawscreen()
if (tonumber(arg[3]) == 1) then
	drawdebug()
end
print('Type a direction to move then press enter!')
print('w a s d')
if tonumber(arg[5]) == 0 then --human control
	res = io.read()
else
	if not (playery + 1 > tonumber(arg[2] - 1)) then
		posup = board[playery + 1][playerx]
		if posup == nil then
			posup = 1
		end
	else
		posup = 1
	end
	if (playery > 1) then
		posdown = board[playery - 1][playerx]
		if posdown == nil then
			posdown = 1
		end
	else
		posdown = 1
	end
	if not (playerx + 1 > tonumber(arg[1] - 1)) then
		posleft = board[playery][playerx + 1]
		if posleft == nil then
			posleft = 1
		end
	else
		posleft = 1
	end
	if not (playerx < 1) then
		posright = board[playery][playerx - 1]
		if posright == nil then
			posright = 1
		end
	else
		posright = 1
	end
	if (applex > playerx) then
		xdir = 1
	elseif (applex < playerx) then
		xdir = -1
	end
	if (appley > playery) then
		ydir = -1
	elseif (appley < playery) then
		ydir = 1
	end
	xdist = diff(applex, playerx)
	ydist = diff(appley, playery)
	if (xdist > 0) and (lives > 250) then
		if (xdir == 1) then
			if not (posleft >= 1) then
				res = 'a'
			else
				res = math.random(4)
			end
		elseif xdir == -1 then
			if not (posright >= 1) then
				res = 'd'
			else
				res = math.random(4)
			end
		end
	elseif (ydist > 0) and (lives > 250) then
		if ydir == 1 then
			if not (posup >= 1) then
				res = 's'
			else
				res = math.random(4)
			end
		elseif ydir == -1 then
			if not (posdown >= 1) then
				res = 'w'
			else
				res = math.random(4)
			end
		end
	else
		res = math.random(4)
	end
	print('Dist to aX: ' .. xdist)
	print('Dist to aY: ' .. ydist)
	print(' ' .. posup)
	print(posleft .. ' ' .. posright)
	print(' ' .. posdown)
	if lives == 4 then
		res = math.random(4)
	end
	if math.random(100) == 1 then
		res = math.random(4)
	end
	randres = 1
	if (res == 'w') or (res == 'a') or (res == 's') or (res == 'd') then
		if (opx == playerx) and (opy == playery) and (lastres == res) then
			randres = 1
		end
		lastres = '' .. res
		randres = 0
	end
	while randres == 1 do
		if (res == lastres) then
			res = math.random(4)
		else
			randres = 0
		end
		if res == 1 then
			res = 'w'
		end
		if res == 2 then
			res = 's'
		end
		if res == 3 then
			res = 'a'
		end
		if res == 4 then
			res = 'd'
		end
	end
	opx = playerx + 0
	opy = playery + 0
	print(res .. '\nPress enter for next step')
	io.read()
end
if (res == 'w') then
	tmp0 = 1
	tmp1 = 0
elseif (res == 's') then
	tmp0 = -1
	tmp1 = 0
elseif (res == 'a') then
	tmp0 = 0
	tmp1 = 1
elseif (res == 'd') then
	tmp0 = 0
	tmp1 = -1
elseif (res == 'q') then
	goto eof
else
	goto bos
end
if (playery + tmp0 > tonumber(arg[2] - 1)) or (playery + tmp0 < 1) or (playerx + tmp1 > tonumber(arg[1] - 1)) or (playerx + tmp1 < 1) then
	goto bos
end
if board[playery + tmp0][playerx + tmp1] == -1 then
	score = score + 1
	board[playery + tmp0][playerx + tmp1] = 0
	apple()
	pause = 1
end
if board[playery + tmp0][playerx + tmp1] > 0 then
	lives = lives - 1
	if lives == 0 then
		print('Game Over!')
		goto eof
	end
end
if board[playery + tmp0][playerx + tmp1] < 2 then
	playery = playery + tmp0
	playerx = playerx + tmp1
	update()
end
goto bos

::eof::