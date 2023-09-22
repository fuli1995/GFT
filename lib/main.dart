import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:upgrader/upgrader.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '/l10n/message.dart';
import 'views/dashboard/main.dart';
import 'views/content_list/main.dart';
import '/views/my/main.dart';
import '/views/login/main.dart';
import '/utilities/permission.dart';
import '/utilities/logger.dart';
import '/config/constants.dart';
import '/components/draggable_button.dart';
import '/components/draggable_devtool.dart';
import '/components/page.dart';

import '/data/controller/user.dart';
import '/data/controller/devtool.dart';
import '/data/controller/setting.dart';
import '/data/controller/bottom_navigation.dart';

class GFTApp extends StatelessWidget {
  GFTApp({super.key});
  final storage = GetStorage();
  final RxBool showDevtool = false.obs;

  @override
  Widget build(BuildContext context) {
    requestCameraPermission(context); // 设备权限校验
    Get.lazyPut(() => LoggerController()); // 注册日志依赖
    Get.lazyPut(() => UserController()); //注册用户信息状态
    Get.put(SettingController());
    Get.put(BottomNavController());
    Get.put(DevtoolController());

    // 禁用屏幕旋转
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp, // 禁用向上的正常方向旋转
      DeviceOrientation.portraitDown, // 禁用向下的旋转
    ]);

    return GetMaterialApp(
      title: 'GFT',
      debugShowCheckedModeBanner: false,
      translations: Messages(), // 翻译文本，国际化初始化在SettingController中
      theme: ThemeData(
        // primarySwatch: Colors.red,
        useMaterial3: true,
        fontFamily: 'Noto Sans Japanese',
      ),
      initialRoute: '/',
      // 全局覆盖一个overlay层，监听没被拦截的事件，实现点击空白处收起键盘的功能
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            SystemChannels.textInput.invokeMethod('TextInput.hide');
          },
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => Stack(
                  children: [
                    child!,
                    if (Config.env != 'prd')
                      Obx(() => showDevtool.value
                          ? DraggableDevtool(onTap: () {
                              showDevtool.value = false;
                            })
                          : DraggableButton(onTap: () {
                              showDevtool.value = true;
                            })),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      getPages: [
        CustomPageRoute(
            name: '/',
            page: () => const DashboardScreen(),
            middlewares: [AuthGuardMiddleware()]),
        CustomPageRoute(name: '/ListScreen', page: () => const ListScreen()),
        CustomPageRoute(name: '/MyScreen', page: () => const MyScreen()),
        CustomPageRoute(name: '/login', page: () => const Login()),
        // page: () => UpgradeAlert(
        //       upgrader: ug,
        //       child: Login(),
        //     )),
      ],
    );
  }
}

Future<void> main() async {
  await SentryFlutter.init(
    (options) => options
      ..dsn = Config.sentryDsn
      ..debug = Config.env != 'prd'
      ..environment = Config.env
      ..attachScreenshot = true
      ..captureFailedRequests = true
      ..tracesSampleRate = 1.0,
    appRunner: () async {
      WidgetsFlutterBinding.ensureInitialized(); // 点击空白处收起键盘功能
      await Upgrader.clearSavedSettings(); // upgrader相关的初始化
      await GetStorage.init();

      return runApp(GFTApp());
    },
  );
}
