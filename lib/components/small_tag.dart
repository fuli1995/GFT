import 'package:flutter/material.dart';
import '/config/color.dart';

class _Theme {
  final Color color;
  final Color bgColor;
  _Theme({required this.color, required this.bgColor});
}

final themeGrey = _Theme(color: C.grey, bgColor: C.ge6);
final themeBlue = _Theme(color: C.blue, bgColor: C.blueBg);
final themeRed = _Theme(color: C.lightRed, bgColor: C.lightRedBg);
final themeGreen = _Theme(color: C.green, bgColor: C.greenBg);

// 标识订单状态的小标签
class SmallTag extends StatelessWidget {
  final String title;
  final String theme;

  const SmallTag({
    super.key,
    required this.title,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final _Theme themeMap = {
          "grey": themeGrey,
          "blue": themeBlue,
          "red": themeRed,
          "green": themeGreen,
        }[theme] ??
        themeGrey;
    return Container(
        padding: const EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
        decoration: BoxDecoration(
            color: themeMap.bgColor, borderRadius: BorderRadius.circular(32)),
        child: Text(
          title,
          style: TextStyle(
              fontSize: 12, color: themeMap.color, fontWeight: FontWeight.w700),
        ));
  }
}
