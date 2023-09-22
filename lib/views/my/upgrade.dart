import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';
import 'package:get/get.dart';

import '/data/controller/setting.dart';

class UpgradePage extends StatelessWidget {
  UpgradePage({super.key});

  final SettingController settingController = Get.find();

  @override
  Widget build(BuildContext context) {
    Upgrader ug = Upgrader(
        debugDisplayAlways: true,
        canDismissDialog: true,
        languageCode: settingController.locale.value.languageCode);

    return Scaffold(
        appBar: AppBar(
          title: Text('update'.tr),
        ),
        body: UpgradeCard(
          upgrader: ug,
        ));
  }
}
