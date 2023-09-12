imbot = {}
--[[ 替换文本函数 ]]
imbot.replace_text = function(table, data)
	if type(table) == 'table' then
		for key, value in pairs(table) do
			if type(value) == 'string' then
				-- 如果匹配到需要替换的键，则进行替换
				for k, v in pairs(data) do
					value = value:gsub(k, v)
				end
				table[key] = value
			elseif type(value) == 'table' then
				-- 如果当前字段是一个表，则递归遍历该表
				replace_text(value, data)
			end
		end
	end
end

-- - - - - - - - - - - - ---
--  _  _____   ___  _  __ --
-- | |/ / _ \ / _ \| |/ / --
-- | ' < (_) | (_) | ' <  --
-- |_|\_\___/ \___/|_|\_\ --
-- - - - - - - - - - - - ---
--[[ 发送KOOK频道聊天消息 ]]
imbot.kook.CreateMessage = function(type, channel, content)
	-- 处理频道ID
	if channel == nil or channel == '' then
		channel = Config.KOOK.Channel.Default
	elseif type(channel) == 'string' then
		channel = Config.KOOK.Channel[channel]
	end

	-- 替换文本
	if type == 9 then
		imbot.replace_text(content[1], content[2])
		content = content[1]
	end
	

	-- 访问接口
	PerformHttpRequest('https://www.kookapp.cn/api/v3/message/create',                         -- URL链接
		function(err, text, headers) end,                                                      -- 返回结果处理函数
		'POST',                                                                                -- 请求方式
		json.encode({ type = type, target_id = channel, content = json.encode(content) }),          -- 请求内容
		{ ['Content-Type'] = 'application/json', ["Authorization"] = 'Bot ' .. Config.KOOK.Token } -- 请求头
	)
end
exports('CreateMessage', imbot.kook.CreateMessage)
RegisterNetEvent('pg_imbot:CreateMessage', imbot.kook.CreateMessage)

-- - - - - - - - --
--   ___   ___   --
--  / _ \ / _ \  --
-- | (_) | (_) | --
--  \__\_\\__\_\ --
-- - - - - - - - --
--[[ 发送QQ群消息 ]]
imbot.qq.SendGroup = function(botQQ, group, content)
	-- 处理机器人QQ
	if botQQ == nil or botQQ == '' then
		botQQ = Config.QQ.DefaultBotQQ
	end

	-- 处理群号
	if group == nil or group == '' then
		channel = Config.QQ.Group.Default
	elseif type(group) == 'string' then
		group = Config.QQ.Group[group]
	end

	-- 访问接口
	PerformHttpRequest('http://127.0.0.1:' .. Config.QQ.Port, -- URL链接
		function(err, text, headers) end,                     -- 返回结果处理函数
		'POST',                                               -- 请求方式
		'<0ewqwi>' .. Config.QQ.BotQQ .. '</0ewqwi><I1ed5q>' .. group .. '</I1ed5q><W18kpc>' .. content .. '</W18kpc>'
	)
end
exports('SendGroup', imbot.qq.SendGroup)
RegisterNetEvent('pg_imbot:SendGroup', imbot.qq.SendGroup)

--[[ HTTP请求处理 ]]
SetHttpHandler(function(request, response)
	request.setDataHandler(function(data)
		local data = json.decode(data)
		-- TriggerClientEvent('table', -1, { request, response, data })
		if data.d ~= nil and data.d.verify_token == Config.KOOK.VerifyToken then
			if KookEventsHandler[data.d.channel_type] then
				KookEventsHandler[data.d.channel_type](request, response, data)
			else
				response.send('404')
			end
		elseif request.path == '/bind' then
			local var1 = exports.pg_loadingscreen:verifyCode(data.verifyCode, 'qq', data.user)
			response.send(tostring(var1))
		else
			request.setCancelHandler(function() end)
		end
	end)
end)
