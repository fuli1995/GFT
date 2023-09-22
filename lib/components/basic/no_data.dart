import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/config/color.dart';

class NoData extends StatelessWidget {
  final String? text;

  const NoData({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset('assets/images/no_data.png', width: 90, height: 90),
        const SizedBox(height: 24),
        Text(text ?? 'noData'.tr,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: C.g33))
      ]),
    );
  }
}
