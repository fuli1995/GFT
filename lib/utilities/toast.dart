import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import '/components/basic/text.dart';
import '/config/color.dart';

List<String> msgList = [];

void showSnackbar(
    {required String msg,
    required Color borderColor,
    required Color backgroundColor,
    required Widget icon}) {
  if (!msgList.contains(msg)) {
    // 节流操作，2s内如果有相同的提醒，只执行第一个
    msgList.add(msg);
    Timer(const Duration(seconds: 2), () {
      msgList.remove(msg);
    });
    Get.showSnackbar(GetSnackBar(
        borderColor: borderColor,
        backgroundColor: backgroundColor,
        icon: icon,
//
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 160),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        borderRadius: 8,
        messageText: BoldText(msg),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2)));
  }
}

class Toast {
  static void info(String msg) {
    Get.snackbar('notice'.tr, msg);
  }

  static void success(String msg) {
    showSnackbar(
      msg: msg,
      borderColor: C.green,
      backgroundColor: C.greenBg,
      icon: Image.asset(
        'assets/icons/success.png',
        width: 24,
        height: 24,
      ),
    );
  }

  static void fail(String msg) {
    showSnackbar(
      msg: msg,
      borderColor: C.grey,
      backgroundColor: C.ge6,
      icon: Image.asset(
        'assets/icons/failed.png',
        width: 24,
        height: 24,
      ),
    );
  }

  static void error(String msg) {
    showSnackbar(
      msg: msg,
      borderColor: C.red,
      backgroundColor: C.paleYellow,
      icon: Image.asset(
        'assets/icons/error.png',
        width: 24,
        height: 24,
      ),
    );
  }
}
