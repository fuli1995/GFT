import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomPageRoute extends GetPage {
  CustomPageRoute({
    required String name,
    required GetPageBuilder page,
    List<GetMiddleware>? middlewares,
  }) : super(
          name: name,
          middlewares: middlewares,
          page: page,
          customTransition: NoTransition(), // 在这里定义自定义的页面切换动画
        );
}

class NoTransition extends CustomTransition {
  @override
  Widget buildTransition(
    BuildContext context,
    Curve? curve,
    Alignment? alignment,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0), // 页面进入时的偏移
        end: Offset.zero, // 页面结束时的偏移
      ).animate(animation),
      child: child,
    );
  }
}
