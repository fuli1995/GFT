import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

Future<void> requestCameraPermission(BuildContext context1) async {
  // 请求相机权限
  var status = await Permission.camera.request();
  var locationsStatus = await Permission.location.request();
  if (status.isGranted && locationsStatus.isGranted) {
    // 已经授权，执行相机操作
    if (kDebugMode) {}
  } else {
    // 未授权，处理未授权的情况
    if (kDebugMode) {}
    // openAppSettings();
    // 用户拒绝了权限请求
    showDialog(
      context: context1,
      builder: (BuildContext context) => AlertDialog(
        title: Text('cameraRequestTitle'.tr),
        content: Text('cameraHint'.tr),
        actions: <Widget>[
          ElevatedButton(
            child: Text('cancel'.tr),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ElevatedButton(
            child: Text('openSetting'.tr),
            onPressed: () => openAppSettings(),
          ),
        ],
      ),
    );
  }
}
