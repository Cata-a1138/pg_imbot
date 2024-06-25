_g = {
	KOOKEventsHandler = {},
	QQEventsHandler = {},
	CommandSymbolLen = string.len(Config.CommandSymbol),
}

ImBot = {
	Config = Config,
	KOOK = {},
	QQ = {},
}

---调用事件处理程序
---@param handlers table
---@param request table
---@param response table
---@param data table
local function callEventHandler(handlers, request, response, data)
	if handlers then
		for _, v in pairs(handlers) do
			local doBreak = false
			local _response = setmetatable({}, {
				__index = function(self, index)
					doBreak = true
					return response[index]
				end,
			})
			v(request, _response, data)

			-- 防止重复发送返回信息
			if doBreak then return end
		end
	end

	-- 若对应事件没有注册的处理程序, 或没有处理程序响应, 返回默认响应
	response.writeHead(200)
	response.send()
end

-- HTTP请求处理
SetHttpHandler(function(request, response)
	-- 请求方式错误
	if request.method == 'GET' then
		response.writeHead(404)
		response.send()
		return
	end

	request.setDataHandler(function(data)
		local _data = json.decode(data)
		if request.path:find('/kook') and _data.d.verify_token == Config.KOOK.VerifyToken then
			callEventHandler(_g.KOOKEventsHandler[_data.d.channel_type], request, response, _data.d)
		elseif request.path == '/qq' then
			callEventHandler(_g.QQEventsHandler[_data.post_type], request, response, _data)
		else
			-- 路径不存在
			response.writeHead(404)
			response.send()
		end
	end)
end)

exports('getSharedObject', function()
	return ImBot
end)
