import 'package:flutter/material.dart';
import '/config/color.dart';

class CardContainer extends StatelessWidget {
  final Widget child;
  final bool? noMargin;

  const CardContainer({Key? key, required this.child, this.noMargin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: noMargin == true
            ? null
            : const EdgeInsets.only(top: 16, left: 16, right: 16),
        padding: noMargin == true
            ? const EdgeInsets.symmetric(vertical: 6, horizontal: 12)
            : const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: C.gd6, width: 1),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: child);
  }
}
