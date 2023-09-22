import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';

import '/config/constants.dart';
import '/data/controller/devtool.dart';
import '/utilities/toast.dart';

class BaseService extends GetConnect {
  final storage = GetStorage();
  final devC = Get.put(DevtoolController());

  @override
  void onInit() {
    httpClient.addRequestModifier<dynamic>((request) {
      bool isLogin = ['login'].contains(request.url.toString().split('/').last);

      if (!isLogin) {
        var token = storage.read('gft-user-token');
        request.headers['Authorization'] = "Bearer $token";
      }
      return request;
    });
    httpClient.baseUrl = Config.baseUrl;

    httpClient.timeout = const Duration(seconds: 60);
    httpClient.addResponseModifier<dynamic>((request, response) async {
      if (Config.env != 'prd') {
        devC.addHttpInfo(
            '${request.url.toString()}\n\n${await request.bodyBytes.transform(utf8.decoder).join()}\n\n${response.body}\n');
      }

      if (response.statusCode == 401) {
        // 跳转到登录页面
        Get.offAllNamed('/login');
      } else if (response.statusCode! > 499 && response.statusCode! < 600) {
        Toast.error('serverError'.tr);
      }
      if ((response.body != null && response.body.runtimeType != String) &&
          (response.body['errcode'] != 0 && response.body['errmsg'] != null)) {
        Toast.error('err${response.body["errcode"]}'.tr);
      }
      return response;
    });

    super.onInit();
  }
}
