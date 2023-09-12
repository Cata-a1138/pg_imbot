KookCommandHandler = {
	bind = function(data, command, args)
		if args[2] ~= nil then
			local var1 = exports.pg_loadingscreen:verifyCode(args[2], 'kook', {
				account = data.d.extra.author.id,
				userName = data.d.extra.author.username..'#'..data.d.extra.author.identify_num,
				nickName = data.d.extra.author.nickname,
				avatar = data.d.extra.author.avatar
			})
			-- SendKOOKCard()
		end
	end,
}

KookEventsHandler = {
	WEBHOOK_CHALLENGE = function(request, response, data)
		response.send(json.encode({ challenge = data.d.challenge }))
	end,
	GROUP = function(request, response, data)
		if data.d.type == 1 or data.d.type == 9 then
			if string.sub(data.d.content, 1, 1) == '/' then
				local command = string.sub(data.d.content, 2)
				local args = pg_lib.split(command, ' ')
				if KookCommandHandler[args[1]] then
					KookCommandHandler[args[1]](data, command, args)
				end
			end
		end
		response.send('200')
	end,
}