---添加事件处理程序
---@param event string
---@param id string
---@param cb fun(request, response, data)
function ImBot.KOOK.AddEventHandler(event, id, cb)
	if not _g.KOOKEventsHandler[event] then _g.KOOKEventsHandler[event] = {} end
	_g.KOOKEventsHandler[event][id] = cb
end

---处理 Challenge 请求
ImBot.KOOK.AddEventHandler('WEBHOOK_CHALLENGE', 'WebChallenge', function(_, response, data)
	response.send(json.encode({ challenge = data.challenge }))
end)

local KOOKCommandHandler = {}

---添加命令
---@param command string
---@param cb fun(args, rawData)
---@param restricted? { target_id?: string | string[], role_id?: number | number[] }
function ImBot.KOOK.AddCommand(command, cb, restricted)
	KOOKCommandHandler[command] = { cb = cb, restricted = restricted }
end

---处理命令
ImBot.KOOK.AddEventHandler('GROUP', 'CommandHandler', function(_, _, data)
	if data.type ~= 1 and data.type ~= 9 then return end

	if string.sub(data.content, 1, _g.CommandSymbolLen) == Config.CommandSymbol then
		local rawCommand = string.sub(data.content, _g.CommandSymbolLen + 1)
		local args = { string.strsplit(' ', rawCommand) }
		local command = args[1]
		table.remove(args, 1)
		if KOOKCommandHandler[command] then
			-- 权限检查
			if KOOKCommandHandler[command].restricted then
				local restricted = KOOKCommandHandler[command].restricted

				-- 检查是否在指定频道
				if restricted.target_id and not lib.table.contains(
					type(restricted.target_id) == 'table' and restricted.target_id or { restricted.target_id }, data.target_id) then return end

				-- 检查是否有所需角色
				if restricted.role_id then
					if type(restricted.role_id) == 'table' then
						local hasrole = false
						for _, v1 in pairs(restricted.role_id) do
							for _, v2 in pairs(data.extra.author.roles) do
								if v1 == v2 then
									hasrole = true
									break
								end
							end
						end
						if not hasrole then return end
					else
						if not lib.table.contains(data.extra.author.roles, restricted.role_id) then return end
					end
				end
			end
			KOOKCommandHandler[command].cb(args, data)
		end
	end
end)
