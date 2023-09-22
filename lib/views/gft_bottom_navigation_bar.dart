import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/data/controller/bottom_navigation.dart';
import '/data/controller/user.dart';
import '/config/color.dart';

class NavItem extends StatelessWidget {
  final Widget icon;
  final String label;
  final bool isFocused;
  final Function? onTap;

  const NavItem(
      {super.key,
      required this.icon,
      required this.label,
      required this.isFocused,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Column(
        children: [
          icon,
          Text(
            label,
            style: TextStyle(color: isFocused ? C.primary : C.g5c),
          )
        ],
      ),
    );
  }
}

class GftBottomNavigationBar extends StatefulWidget {
  const GftBottomNavigationBar({super.key});

  @override
  State<StatefulWidget> createState() => GftBottomNavigationBarState();
}

class GftBottomNavigationBarState extends State<GftBottomNavigationBar> {
  final BottomNavController bCtl = Get.find();
  final UserController uCtl = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => BottomNavigationBar(
          selectedItemColor: C.primary,
          currentIndex:
              bCtl.currentIndex.value, // todo: 退出后重登陆时，value更新不及时会导致报错
          type: BottomNavigationBarType.fixed,
          iconSize: 36,
          onTap: bCtl.switchIndex,
          items: [
            BottomNavigationBarItem(
                icon: const Icon(Icons.home_outlined), label: 'Home'.tr),
            BottomNavigationBarItem(
                icon: const Icon(Icons.task_outlined), label: 'List'.tr),
            BottomNavigationBarItem(
                icon: const Icon(Icons.person), label: 'My'.tr),
          ],
        ));
  }
}
