if not (arg[1] and arg[2] and arg[3] and arg[4]) then
	print('Missing arguments!\n' .. arg[0] .. ' [grid size x + 1] [grid size y + 1] [debug] [ultra hard mode]')
	goto eof
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
				string = string .. '  '
			elseif (tmp2 > 0) and (tmp2 < score) then
				string = string .. '# '
			elseif (tmp2 == score) then
				string = string .. 'O '
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
	lives = 4
	board[playery][playerx] = score
end

--init
math.randomseed(os.time())
steps = 0
score = 3
applex = 0
appley = 0
pause = 0
lives = 4
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
print('Type a direction to move or \'q\' to quit then press enter!')
print('w a s d')
res = io.read()
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
