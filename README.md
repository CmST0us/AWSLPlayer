# 我永远喜欢...
这是一款iOS播放器，最主要的功能就是同屏播放多个直播。
人之初，性本D，誰でも大好き！
项目正在开发中...

当前版本`0.1`

feature:
- [x] BiliBili 拉流逻辑
- [ ] hls播放组件
- [ ] Youtube 拉流逻辑
- [ ] NicoNico 拉流逻辑
- [ ] 其他平台拉流逻辑
- [ ] 录屏
- [ ] 弹幕

## 各大直播平台流拉取逻辑

### BiliBili *WIP*

1. 首先获取真实房间号
GET `https://api.live.bilibili.com/room/v1/Room/room_init?id=${roomId}`
这里需要说明的是为什么会存在一个真实房间号。其实主要是B站大主播直播间通常是一些短房间号，需要通过请求获取真实的长房间号。其实就是类似手机长号短号的情况。

2. 获取流
GET `https://api.live.bilibili.com/api/playurl?cid=${realRoomId}&otype=json&quality=0&platform=web`

3. 拉取流

### NicoNico *WIP*
1. HTML请求获取页面配置
GET `http://live2.nicovideo.jp/watch/lv${videoId}`

2. HTML解析
使用选择器`$('#embedded-data').attr('data-props')`获取配置JSON

3. 创建WebSocket
通过第二步获取到的JSON中的WebSocket URL`site.relive.webSocketUrl`和广播ID`program.broadcastId`创建WebSocket。

4. 发送请求
创建成功WebSocket之后发送JSON
```JSON

{
      type: 'watch',
      body: {
        command: 'getpermit',
        requirement: {
          ${broadcastId},
          route: '',
          stream: {
            protocol: 'hls',
            requireNewStream: true,
            priorStreamQuality: 'high',
            isLowLatency: true
          },
          room: {
            isCommentable: true,
            protocol: 'webSocket'
          }
        }
      }
}

```
5. 接收数据
发送请求JSON成功之后开始接收数据。收到的数据为JSON格式

5.1. 收到心跳包
当WebSocket收到对方的包的type为ping时，发送pong包作为心跳。发送的pong包格式为
```JSON
{
  types: 'pong',
  body: {}
}
```

5.2. 收到非心跳消息包
如果`body.command`为servertime
发送JSON

```JSON
{
            type: 'watch',
            body: {
              command: 'watching',
              params: [${broadcastId}, '-1', '0']
            }
}
```

如果`body.command`为currentstream
即可获取流地址`body.currentStream.uri`

### Youtube *WIP*
1. 打开直播页面，加载Javascript引擎
var config = JSON.parse(ytplayer.config.args.player_response)
得到的结果中config.streamingData.hlsManifestUrl即播放地址


