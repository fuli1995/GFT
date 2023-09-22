import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '/data/controller/bottom_navigation.dart';

class User {
  String? username;
  String? token;
  Map userInfo = {};

  void setUserInfo(userInfoRes) {
    userInfo = userInfoRes;
  }

  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
      json['username'] as String,
      json['token'] as String,
      jsonDecode(json['userInfo']) as Map<String, dynamic>,
    );
  }

  Map<String, dynamic> toJson() =>
      {'username': username, 'token': token, 'userInfo': jsonEncode(userInfo)};

  User(this.username, this.token, this.userInfo);
}

class UserController extends GetxController {
  final storage = GetStorage();

  Rx<User> user = User('', '', {}).obs; // 详细的用户信息，用于更新界面
  bool get isLogged => user.value.username?.isNotEmpty ?? false; // 标识用户是否已经登录

  // 记住账号密码功能
  RxBool rememberAccount = true.obs;
  RxString account = ''.obs;
  RxString password = ''.obs;

  // 优化输入账号密码时的显示
  RxBool isFocusedOnInput = false.obs;
  RxBool isLoading = false.obs;

  void switchLoading([bool? loading]) {
    if (loading != null) {
      isLoading.value = loading;
    } else {
      isLoading.value = isLoading.value ? false : true;
    }
  }

  void updateUserValue(User value) {
    storage.write('gft-user', value);
    storage.write('gft-user-token', value.token);
  }

  @override
  void onInit() {
    super.onInit();

    // 监听并同步保存userInfo到本地
    ever(user, updateUserValue);

// 读取本地缓存。包括用户信息，记住的账号和密码
    var storageUser = storage.read('gft-user');
    var passwordStr = storage.read('gft-user-password');
    var accountStr = storage.read('gft-user-account');

    rememberAccount.value =
        rememberAccount.value || (passwordStr != null && passwordStr != '');
    password.value = passwordStr ?? '';
    account.value = accountStr ?? '';

    try {
      user.value = User.fromJson(storageUser);
    } catch (e) {
      user.value = user.value;
    }
  }

  Future<bool> login(String username, String passwordStr) async {
    var loginState = false; // 标识登录是否成功
    switchLoading(true);
    try {
      // 记住账号密码功能
      account.value = rememberAccount.value ? username : '';
      password.value = rememberAccount.value ? passwordStr : '';
      storage.write('gft-user-account', account.value);
      storage.write('gft-user-password', password.value);

      // Map data = {
      //   'data': {
      //     'username': username,
      //     'password': passwordEncrypt,
      //     'rememberMe': true
      //   }
      // };
      // should be http request
      var res = {
        "user": {
          "username": "user 1",
          "name": null,
          "password": "",
        },
        "token": ""
        // "eyJ0eXBlIjoiSldUIiwiYWxnIjoiSFMyNTYifQ.eyJyb2xlIjpbXSwidXNlcl9uYW1lIjoidGVzdHVzZXIxIiwidG9rZW5WZXJzaW9uIjoxNjk1MTc4NTkwOTMzLCJpc3MiOiJzZWN1cml0eSIsImlhdCI6MTY5NTE3ODU5MCwiYXVkIjoic2VjdXJpdHktYWxsIiwiZXhwIjoxNjk1NzgzMzkwfQ.90_YZFToovt55Iv6T3_Q37ZwviyFHPm6mVZFKjpiufQ"
      };

      if (res['user'] != null) {
        var userInfo = res['user'] as Map;
        var token = res['token'] as String;
        var userName = userInfo['username'];

        user.value = User(userName, token, userInfo);

        loginState = true;
      } else if (res['errmsg'] != null) {
        throw Exception(res['errmsg']);
      }
    } catch (e) {
      rethrow;
    }
    switchLoading(false);
    return loginState;
  }

  void logout() async {
    switchLoading(true);

    try {
      Get.find<BottomNavController>().resetBar(); //todo: 应该让bar自己销毁重建

      Get.offNamed('login');
      var u = User('', '', {});
      updateUserValue(u);
    } catch (e) {
      switchLoading(false);
      rethrow;
    }

    switchLoading(false);
  }
}

// AuthGuardMiddleware 中间件用于检查用户是否已认证，并强制将未认证的用户重定向到登录页面
class AuthGuardMiddleware extends GetMiddleware {
  final UserController authController = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    if (!authController.isLogged && route != '/login') {
      return const RouteSettings(name: '/login');
    }
    return null;
  }
}
