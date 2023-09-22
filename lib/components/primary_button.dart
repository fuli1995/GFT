import 'package:flutter/material.dart';
import '/config/color.dart';

// primary色的按钮,可支持空onTap，由父组件来处理点击事件
class PrimaryButton extends StatelessWidget {
  final String text;
  final String? size;
  final Function? onTap;
  final Widget? icon;
  final bool? disabled;
  final bool? isWhite;

  const PrimaryButton({
    super.key,
    required this.text,
    this.size,
    this.onTap,
    this.icon,
    this.disabled,
    this.isWhite,
  });

  @override
  Widget build(BuildContext context) {
    final Color bgColor =
        disabled == true ? C.gd6 : (isWhite == true ? C.white : C.primary);
    final Color fontColor =
        (isWhite == true && disabled == null) ? C.primary : C.white;
    final Color borderColor = disabled == true ? C.gd6 : C.primary;

    double textSize = size == 'large' ? 20 : 16;
    double height = size == 'large' ? 48 : 40;

    final Text textWidget = Text(
      text,
      style: TextStyle(
          fontSize: textSize, fontWeight: FontWeight.w500, color: fontColor),
    );

    return onTap == null
        ? Container(
            alignment: Alignment.center,
            height: height,
            padding: const EdgeInsets.only(left: 8, right: 8),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: borderColor, width: 1),
            ),
            child: textWidget,
          )
        : TextButton(
            onPressed: () {
              if (disabled == true) return;
              onTap!();
            },
            style: TextButton.styleFrom(
              fixedSize: Size(double.infinity, height),
              backgroundColor: bgColor,
              side: BorderSide(color: borderColor, width: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: textWidget,
          );
  }
}
