# GFT

GFT Flutter project.

_flutter 的开发调试支持多个操作系统（MacOS，Windows，Linux），但是若想要开发和调试 iOS 或 MacOS 软件，必须在 Mac 电脑上，并安装 Xcode 等相关软件。下面的教程都假定你使用的是 Mac 电脑+VS code IDE_

技术栈说明文档：https://alidocs.dingtalk.com/i/nodes/dxXB52LJq0aj1ardi1g1pzEYVqjMp697?utm_scene=team_space

## 环境配置

### flutter 开发环境（MacOS）

https://docs.google.com/document/d/10ooUjuBB7av3rIgrLlkzyi8ZotkwVRvY8Au48ED0MSA/edit#

## 运行和调试

请先在 VS code 中安装 dart 和 flutter 插件。

1. 确保模拟器出于运行状态
   你可以手动启动 Xcode 或安卓模拟器，或者在 VS code 中启动模拟器。
   vs code 中选择模拟器
   [![ppcrUij.png](https://s1.ax1x.com/2023/03/29/ppcrUij.png)](https://imgse.com/i/ppcrUij)
   在电脑安装过模拟器后，vs code 中就会出现对应的选项
   [![ppcryeU.jpg](https://s1.ax1x.com/2023/03/29/ppcryeU.jpg)](https://imgse.com/i/ppcryeU)

2. 启动应用
   在命令行中输入`flutter run`命令，或者使用 vs code 中的 run and debug 功能

提醒：
在连接手机进行调试时，mac 电脑可能会拦截某些必要软件的安装。可以用`sudo spctl --master-disable`命令，将允许运行的 app 设置为“任何来源”

## 项目结构

项目结构及功能说明如下

```
|-- lib // 主要的开发目录，其他目录主要是一些配置文件、图片资源和打包产物
    |
    |-- components // 项目中需要定制化的通用组件，例如带确认弹出框的按钮
    |-- generated // 国际化相关
    |-- l10n // 国际化相关
    |
    |-- utilities // 一些工具函数
    |   |--permission.dart // 处理相机、网络等权限请求
    |
    |-- views // 主要的功能界面，一个文件夹对应一个功能模块
    |   |-- common_views // 一些在多个模块出现的试图
    |   |   |-- order_detail.dart // 物流订单详情视图
    |   |-- delivery
    |   |-- my
    |   |-- order
    |   |   |-- main.dart // order模块下的主视图
    |   |   |-- order_list.dart // order模块下的订单列表视图
    |
    |   |-- home.dart // app的首页视图
    |
    |-- main.dart // app入口文件
```

## 其他

使用了 flavor 配置以后，无法在 vs code 中以配置形式运行 debug 模式，需要用命令行启动。
`flutter run --flavor dev --dart-define=EnvName=dev --hot`

1.  修改完 model 下的类型定义后，运行
    `dart run build_runner build`
    重新生成 fromJson 方法

2.  修改完 icon 图标（注意 icon 背景部分不能为透明，可以使用https://www.photopea.com/在线转换）后，运行
    `dart run flutter_launcher_icons`
    重新生成所有客户端所有尺寸的图标
