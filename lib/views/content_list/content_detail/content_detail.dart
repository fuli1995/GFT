import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/content.dart';
import '/config/color.dart';
import '/components/primary_button.dart';
import '/components/small_tag.dart';
import '/components/basic/info_card.dart';

class ContentDetailPage extends StatefulWidget {
  final Content contentInfo;

  const ContentDetailPage({Key? key, required this.contentInfo})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ContentDetailPageState();
}

class ContentDetailPageState extends State<ContentDetailPage> {
  @override
  Widget build(BuildContext context) {
    final Content cInfo = widget.contentInfo;

    return Scaffold(
        appBar: AppBar(
          title: Text('Content Details'.tr),
        ),
        backgroundColor: C.g5c,
        body: Column(children: [
          Expanded(
              child: Container(
            color: C.white,
            padding: const EdgeInsets.only(top: 24, left: 12, right: 12),
            child: SingleChildScrollView(
                child: Column(
              children: [
                Row(children: [
                  SmallTag(
                      title: cInfo.field2 ?? '',
                      theme: {
                            'status 1': 'blue',
                            'status 2': 'green',
                            'status 3': 'red'
                          }[cInfo.field2] ??
                          'grey')
                ]),
                const SizedBox(height: 8),
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cInfo.field3 ?? '',
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: C.g5c),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            cInfo.field4 ?? '',
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: C.g33),
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                InfoCard(
                  title: '',
                  infoMap: {
                    'Info1': cInfo.field1,
                    'Info2': cInfo.field2,
                    'Info3': cInfo.field3,
                    'Info4': cInfo.field4,
                  },
                ),
                InfoCard(
                  title: 'some info'.tr,
                  infoMap: {
                    'Info1': cInfo.field1,
                    'Info2': cInfo.field2,
                    'Info3': cInfo.field3,
                    'Info4': cInfo.field4,
                  },
                ),
                const SizedBox(height: 80)
              ],
            )),
          )),
          Container(
              width: double.infinity,
              color: C.white,
              padding: const EdgeInsets.all(16),
              child: SafeArea(
                  child: PrimaryButton(
                      text: 'Continue'.tr, size: 'large', onTap: () {}))),
        ]));
  }
}
