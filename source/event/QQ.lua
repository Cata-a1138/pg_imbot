---添加事件处理程序
---@param event string
---@param id string
---@param cb fun(data)
function ImBot.QQ.AddEventHandler(event, id, cb)
    if not _g.QQEventsHandler[event] then _g.QQEventsHandler[event] = {} end
	_g.QQEventsHandler[event][id] = cb
end

local QQCommandHandler = {}

---添加命令
---@param command string
---@param cb fun(args, rawData)
---@param restricted? { user_id?: number | number[], group_id?: number | number[] }
function ImBot.QQ.AddCommand(command, cb, restricted)
	QQCommandHandler[command] = { cb = cb, restricted = restricted }
end

-- 处理命令
ImBot.QQ.AddEventHandler('message', 'CommandHandler', function(_, _, data)
    if string.sub(data.raw_message, 1, _g.CommandSymbolLen) == Config.CommandSymbol then
		local rawCommand = string.sub(data.raw_message, _g.CommandSymbolLen + 1)
		local args = { string.strsplit(' ', rawCommand) }
		local command = args[1]
		table.remove(args, 1)
		if QQCommandHandler[command] then
			-- 权限检查
            if QQCommandHandler[command].restricted then
				local restricted = QQCommandHandler[command].restricted
                -- 检查是否特点账号私聊
                if data.message_type == 'private' and restricted.user_id and not lib.table.contains(
					type(restricted.user_id) == 'table' and restricted.user_id or { restricted.user_id }, data.user_id) then return end

                -- 检查是否特定群聊
                if data.message_type == 'group' and restricted.group_id and not lib.table.contains(
					type(restricted.group_id) == 'table' and restricted.group_id or { restricted.group_id }, data.group_id) then return end
            end
			QQCommandHandler[command].cb(args, data)
		end
	end
end)
