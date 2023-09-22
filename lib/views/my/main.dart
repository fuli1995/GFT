import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:url_launcher/url_launcher.dart";

import '../gft_bottom_navigation_bar.dart';
import './profile.dart';
import './setting.dart';
import './feedback.dart';
import './upgrade.dart';

import '/config/color.dart';
import '/data/controller/user.dart';
import '/components/basic/text.dart';
import '/components/basic/long_rect_button.dart';

class MyScreen extends StatefulWidget {
  const MyScreen({super.key});

  @override
  State<StatefulWidget> createState() => MyScreenState();
}

class MyScreenState extends State<StatefulWidget> {
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.gf6,
      body: Column(children: [
        // 上半部分，用户信息展示区
        const SizedBox(height: 24),
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: C.white, borderRadius: BorderRadius.circular(16)),
          child: const Row(
            children: [
              CircleAvatar(
                  radius: 32,
                  backgroundImage: AssetImage('assets/images/avatar.png')),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BoldText('Username'),
                  SizedBox(height: 8),
                  SmallText('some profile text.'),
                ],
              ),
            ],
          ),
        ),
        // 下半部分，选项模块区域
        Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: C.white, borderRadius: BorderRadius.circular(16)),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  SmallLongRectButton(
                      text: 'Personal Information'.tr,
                      imageIcon: Icon(Icons.person, color: C.primary),
                      onTap: () {
                        Get.to(() => Profile());
                      }),
                  SmallLongRectButton(
                      text: 'System Setting'.tr,
                      imageIcon: Icon(Icons.settings, color: C.primary),
                      onTap: () {
                        Get.to(() => Setting());
                      }),
                  SmallLongRectButton(
                      text: 'Handbook'.tr,
                      imageIcon: Icon(Icons.menu_book, color: C.primary),
                      onTap: () async {
                        Uri handbookUrl = Uri.parse('https://www.google.com');

                        if (await canLaunchUrl(handbookUrl)) {
                          await launchUrl(
                            handbookUrl,
                            mode: LaunchMode.externalApplication,
                          );
                        } else {
                          throw 'Can\'t open Link';
                        }
                      }),
                  SmallLongRectButton(
                      text: 'Feedback'.tr,
                      imageIcon:
                          Icon(Icons.feedback_outlined, color: C.primary),
                      onTap: () {
                        Get.to(() => const FeedbackPage());
                      }),
                  SmallLongRectButton(
                      text: 'Update'.tr,
                      imageIcon: Icon(Icons.update, color: C.primary),
                      onTap: () {
                        Get.to(() => UpgradePage());
                      }),
                  SmallLongRectButton(
                      text: 'Logout'.tr,
                      imageIcon: Icon(Icons.logout, color: C.primary),
                      onTap: () {
                        userController.logout();
                      }),
                ],
              ),
            )),
      ]),
      bottomNavigationBar: const GftBottomNavigationBar(),
    );
  }
}
