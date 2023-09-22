import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/data/controller/setting.dart';

class Setting extends StatelessWidget {
  final SettingController settingController = Get.find();

  Setting({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('systemSetting'.tr),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('languageSelection'.tr),
          ),
          Obx(() => Column(
                children: [
                  RadioListTile(
                    value: '',
                    groupValue: settingController.languageCode.value,
                    onChanged: (String? value) {
                      settingController.switchLanguage(value!);
                    },
                    title: Text('followSystem'.tr),
                  ),
                  RadioListTile(
                    value: 'ja',
                    groupValue: settingController.languageCode.value,
                    onChanged: (String? value) {
                      settingController.switchLanguage(value!);
                    },
                    title: Text('japanese'.tr),
                  ),
                  RadioListTile(
                    value: 'zh',
                    groupValue: settingController.languageCode.value,
                    onChanged: (String? value) {
                      settingController.switchLanguage(value!);
                    },
                    title: Text('chinese'.tr),
                  ),
                  RadioListTile(
                    value: 'en',
                    groupValue: settingController.languageCode.value,
                    onChanged: (String? value) {
                      settingController.switchLanguage(value!);
                    },
                    title: Text('english'.tr),
                  ),
                ],
              )),
          // ListTile(
          //   title: Text('themeSelection'.tr),
          //   trailing: Icon(Icons.arrow_forward_ios),
          // ),
        ],
      ),
    );
  }
}
