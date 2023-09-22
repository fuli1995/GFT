import 'package:flutter/material.dart';

import '/components/basic/text.dart';
import '/config/color.dart';

// 小卡片按钮
class SmallCardButton extends StatelessWidget {
  final String text;
  final String? smallText;
  final Function onTap;
  final Widget? icon;

  const SmallCardButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.icon,
      this.smallText});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth = (screenWidth - 48) / 2;
    final double textWidth = cardWidth - 40 - 12 - 16 - 2;
    return InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
            width: cardWidth,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: C.gee),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey.withOpacity(0.1),
                //     spreadRadius: 2,
                //     blurRadius: 2,
                //     offset: const Offset(
                //         5, 5), // controls the position of the shadow
                //   ),
                // ],
                color: C.white,
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                icon ?? Container(),
                const SizedBox(width: 12),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: textWidth, child: BoldText(text)),
                    if (smallText != null)
                      SizedBox(
                        width: textWidth,
                        child: MiniText(smallText!),
                      )
                  ],
                )
              ],
            )));
  }
}
