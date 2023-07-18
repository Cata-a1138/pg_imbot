--[[ 替换文本函数 ]]
local function replace_text(table, data)
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

--[[ 发送KOOK卡片消息 ]]
local function SendKOOKCard(channel, card, data)
  -- 处理频道ID
  if channel == nil or channel == '' then
    channel = Config.KOOK.Channel.Default
  elseif type(channel) == 'string' then
    channel = Config.KOOK.Channel[channel]
  end

  -- 替换文本
  replace_text(card, data)

  -- 访问接口
  PerformHttpRequest('https://www.kookapp.cn/api/v3/message/create', -- URL链接
    function(err, text, headers) end, -- 返回结果处理函数
    'POST', -- 请求方式
    json.encode({type=10,target_id=channel,content=json.encode(card)}), -- 请求内容
    {['Content-Type'] = 'application/json', ["Authorization"] = 'Bot '..Config.KOOK.Token} -- 请求头
  )
end
exports('SendKOOKCard', SendKOOKCard)
RegisterNetEvent('pg_imbot:SendKOOKCard', SendKOOKCard)

--[[ 发送QQ群消息 ]]
local function SendQQGroup(botQQ, group, content)
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
  PerformHttpRequest('http://127.0.0.1:'..Config.QQ.port, -- URL链接
    function(err, text, headers) end, -- 返回结果处理函数
    'POST', -- 请求方式
    '<0ewqwi>'..Config.QQ.botQQ..'</0ewqwi><I1ed5q>'..group..'</I1ed5q><W18kpc>'..content..'</W18kpc>'
  )
end
exports('SendQQGroup', SendQQGroup)
RegisterNetEvent('pg_imbot:SendQQGroup', SendQQGroup)