import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

class SettingController extends GetxController {
  Rx<String> languageCode = ''.obs;
  final storage = GetStorage();
  static Locale fallbackLocale = const Locale('ja', 'JP');

  Rx<Locale> locale = fallbackLocale.obs;

  @override
  void onInit() {
    super.onInit();
    languageCode.value = storage.read('gft-lang') ?? '';

    switchLanguage(languageCode.value);
  }

  void switchLanguage(String lang) {
    languageCode.value = lang;
    storage.write('gft-lang', lang);
    locale.value = [''].contains(lang)
        ? (Get.deviceLocale ?? fallbackLocale)
        : Locale(lang, '');
    Get.updateLocale(locale.value);
  }
}
