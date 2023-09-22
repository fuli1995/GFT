import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'confirm': 'Confirm',
          'cancel': 'Cancel',
        },
        'zh_CN': {
          'confirm': '确认',
          'cancel': '取消',
        },
        'ja_JP': {
          'confirm': '確認',
          'cancel': 'キャンセル',
        },
      };
}
