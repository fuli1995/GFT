import 'package:flutter/material.dart';

import '/config/color.dart';

class LongRectButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Widget? imageIcon;
  final void Function() onTap;
  final Color? iconColor;

  const LongRectButton(
      {super.key,
      required this.text,
      this.icon,
      required this.onTap,
      this.iconColor,
      this.imageIcon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
            margin: const EdgeInsets.only(top: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: C.gee, width: 1),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Row(children: [
              imageIcon ??
                  Icon(icon ?? Icons.abc_outlined,
                      size: 28, color: iconColor ?? C.primary),
              const SizedBox(width: 12),
              Text(text),
              Expanded(child: Container()),
              const Icon(Icons.arrow_forward_ios)
            ])));
  }
}

class SmallLongRectButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Widget? imageIcon;
  final void Function() onTap;
  final Color? iconColor;

  const SmallLongRectButton(
      {super.key,
      required this.text,
      this.icon,
      required this.onTap,
      this.iconColor,
      this.imageIcon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: C.gee, width: 1.0)),
              // borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Row(children: [
              imageIcon ??
                  Icon(icon ?? Icons.abc_outlined,
                      size: 28, color: iconColor ?? C.primary),
              const SizedBox(width: 12),
              Text(text),
              Expanded(child: Container()),
              const Icon(Icons.arrow_forward_ios)
            ])));
  }
}
