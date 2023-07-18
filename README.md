# pg_imbot

## 安装
* 前往 [Release](https://github.com/kasuganosoras/globalban/releases) 下载最新版本的 Source Code
* 将压缩包内的 `pg_imbot-x.x.x` 文件夹放入服务器的 `resources` 目录
* 重命名文件夹为 `pg_imbot`
* 在你的 `server.cfg` 中添加一行 `ensure pg_imbot`

*若不使用QQ机器人，可跳过以下步骤*
* 前往[https://qvbot.com/](https://qvbot.com/)下载框架
* 将 `pg_imbot` 中的 `FiveM机器人.qy.dll` 移动到 `QYBot_VX.X.X\main\plugin`

## 配置
### KOOK
* 前往[https://developer.kookapp.cn/bot/](https://developer.kookapp.cn/bot/)创建应用
* 将机器人的 `Token` 填写到 `config.lua`
* 在 `config.lua` 中填写频道ID

### QQ
* 运行`QYBot.exe`
* 在账号页面空白处右键选择添加，按照提示添加账号
* 右键添加好的账号选择登录
* 在插件页面空白处右键选择添加，选择本插件并单击打开
* 右键本插件选择启用
* 右键选择设置可在弹出的窗口中更改触发指令或指定用户查询的服务器  
  *可从连接指令或Keymaster获取服务器ID*
* 在 `config.lua` 中填写机器人QQ号及群号

## API
利用 pg_imbot 的 API，你可以在你的脚本中向 KOOK/QQ 发送消息

## 发送KOOK卡片消息
```lua
exports.pg_imbot:SendKOOKCard(channelID, card, data)
```
| 参数 | 类型 | 可选 | 描述|
|:-:|:-:|:-:|:-:|
|channelID|string/number|是|要发送信息的频道ID或config中配置的频道名,为空则使用config中Default的值|
|card|table|否|要发送的卡片模板|
|data|table|否|要替换的信息|

示例
```lua
exports.pg_imbot:SendKOOKCard(
    'Admin',
    json.decode(LoadResourceFile(GetCurrentResourceName(), 'Card.json')),
    {title='测试', content='这里是一个啦啦啦啦啦啦超级无敌爆炸螺旋长的公告'}
)
```

## 发送QQ群消息
```lua
exports.pg_imbot:SendQQGroup(botQQ, group, content)
```
| 参数 | 类型 | 可选 | 描述|
|:-:|:-:|:-:|:-:|
|botQQ|number|是|机器人QQ号|
|group|string/number|是|要发送信息的群号或config中配置的名称,为空则使用config中Default的值|
|content|table|否|要发送的信息|

示例
```lua
exports.pg_imbot:SendQQGroup(
    nil,
    324720000,
    '公告\n内容：服务器即将重启'
)
```

## 本插件使用的接口
* FiveM状态  
https://status.atlassian.com/api  
* 服务器信息
服务器IP或域名:30120/dynamic.json   
https://servers-frontend.fivem.net/api/servers/single/服务器ID  

## 许可
本项目使用 GPT v3 协议开源，详情请见 [LICENSE](https://github.com/Cata-a1138/pg_imbot/blob/main/LICENSE)
