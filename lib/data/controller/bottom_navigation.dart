import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/data/controller/user.dart';

class BottomNavController extends GetxController {
  Rx<int> currentIndex = 0.obs;
  UserController uCtl = Get.find();
  Rx<List<BottomNavigationBarItem>> itemList =
      Rx<List<BottomNavigationBarItem>>([
    BottomNavigationBarItem(
        icon: const Icon(Icons.home_outlined), label: 'home'.tr),
    BottomNavigationBarItem(
        icon: const Icon(Icons.task_outlined), label: 'task'.tr),
    BottomNavigationBarItem(icon: const Icon(Icons.person), label: 'my'.tr),
  ]);

  void resetBar() {
    currentIndex.value = 0;
  }

  void switchIndex(int index) {
    currentIndex.value = index;
    switch (index) {
      case 0:
        Get.offNamed('/DashboardScreen');
        break;
      case 1:
        Get.offNamed('/ListScreen');
        break;
      case 2:
        Get.offNamed('/MyScreen');
        break;
    }
  }
}
