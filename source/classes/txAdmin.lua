-- txAdmin公告
AddEventHandler('txAdmin:events:announcement', function(eventData)
	local message = {
		'游戏内公告',
		('内容：%s\n发送者：%s'):format(eventData.message, eventData.author)
	}
	ImBot.CreateMessage(10, 'Notice', {
		json.decode(LoadResourceFile('pg_imbot', 'cards/card.json')), {
			primary = 'info',
			title = message[1],
			content = message[2]
		} })
	ImBot.SendGroup(nil, 'Main', table.concat(message, '\n'))
end)

-- txAdmin服务器即将关闭
AddEventHandler('txAdmin:events:serverShuttingDown', function(eventData)
	local message = {
		'服务器即将重启',
		('操作人：%s'):format(eventData.author == 'txAdmin' and '计划任务' or eventData.author)
	}
	ImBot.CreateMessage(10, 'State', {
		json.decode(LoadResourceFile('pg_imbot', 'cards/card.json')), {
			primary = 'info',
			title = message[1],
			content = message[2]
		} })
	ImBot.SendGroup(nil, 'Main', table.concat(message, '\n'))
end)

--[[ -- txAdmin警告玩家
AddEventHandler('txAdmin:events:playerWarned', function(eventData)
	local message = {
		'玩家处罚公告',
		('玩家：%s\n原因：%s\n处罚方式：:warning:警告\n处理人：%s'):format(GetPlayerName(eventData.target), eventData.reason, eventData.author)
	}
	ImBot.CreateMessage(10, 'Notice', {
		json.decode(LoadResourceFile('pg_imbot', 'cards/card.json')), {
			primary = 'warning',
			title = message[1],
			content = message[2]
		} })
	ImBot.SendGroup(nil, 'Main', string.gsub(table.concat(message, '\n'), ':*[a-z_]*:', ''))
end)

-- txAdmin踢出玩家
AddEventHandler('txAdmin:events:playerKicked', function(eventData)
	local message = {
		'玩家处罚公告',
		('玩家：%s\n原因：%s\n处罚方式：:construction:踢出游戏\n处理人：%s'):format(GetPlayerName(eventData.target), eventData.reason, eventData.author)
	}
	ImBot.CreateMessage(10, 'Notice', {
		json.decode(LoadResourceFile('pg_imbot', 'cards/card.json')), {
			primary = 'warning',
			title = message[1],
			content = message[2]
		} })
	ImBot.SendGroup(nil, 'Main', string.gsub(table.concat(message, '\n'), ':*[a-z_]*:', ''))
end)

-- txAdmin封禁玩家
AddEventHandler('txAdmin:events:playerBanned', function(eventData)
	local message = {
		'玩家处罚公告',
		('玩家：%s\n原因：%s\n处罚方式：%s\n处理人：%s'):format(eventData.targetName, eventData.reason,
		(eventData.expiration and (':no_entry_sign:封禁' .. eventData.durationTranslated) or
		':no_entry_sign:永久封禁'), eventData.author)
	}
	ImBot.CreateMessage(10, 'Notice', {
		json.decode(LoadResourceFile('pg_imbot', 'cards/card.json')), {
			primary = 'danger',
			title = message[1],
			content = message[2]
		} })
	ImBot.SendGroup(nil, 'Main', string.gsub(table.concat(message, '\n'), ':*[a-z_]*:', ''))
end)

-- txAdmin移除警告/封禁玩家
AddEventHandler('txAdmin:events:actionRevoked', function(eventData)
	local message = {
		'处罚撤销通知',
		('管理员：%s 撤销了以下处罚\n玩家：%s\n原因：%s\n处罚方式：%s处理人：%s'):format(eventData.revokedBy, eventData.playerName, eventData.actionReason,
		(eventData.actionType == 'warn' and ':warning:警告\n警告' or ':no_entry_sign:封禁\n封禁'), eventData.actionAuthor)
	}
	ImBot.CreateMessage(10, 'Notice', {
		json.decode(LoadResourceFile('pg_imbot', 'cards/card.json')),
		{
			primary = 'info',
			title = message[1],
			content = message[2]
		} })
	ImBot.SendGroup(nil, 'Main', string.gsub(table.concat(message, '\n'), ':*[a-z_]*:', ''))
end) ]]