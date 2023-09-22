import 'package:flutter/material.dart';

import '/config/color.dart';

Text getText(String text, TextStyle style) {
  return Text(text,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
      style: style);
}

class MiniText extends StatelessWidget {
  final String text;

  const MiniText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return getText(text,
        TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: C.g5c));
  }
}

class SmallText extends StatelessWidget {
  final String text;

  const SmallText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return getText(text,
        TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: C.g33));
  }
}

class NormalText extends StatelessWidget {
  final String text;

  const NormalText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return getText(text,
        TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: C.g33));
  }
}

class BoldText extends StatelessWidget {
  final String text;

  const BoldText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return getText(text,
        TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: C.g33));
  }
}

class LargeText extends StatelessWidget {
  final String text;

  const LargeText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return getText(text,
        TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: C.g33));
  }
}

class SuperLargeText extends StatelessWidget {
  final String text;

  const SuperLargeText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return getText(text,
        TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: C.g33));
  }
}
