import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clipboard/clipboard.dart';
import "package:url_launcher/url_launcher.dart";

import '/config/color.dart';
import '/utilities/toast.dart';

List<String> canCopyList = [
  'orderNo',
  'address',
  'addressFull',
  'phoneNumber',
  'mobilePhoneNumber'
];
List<String> isTelList = ['phoneNumber', 'mobilePhoneNumber'];

// 用于以表单形式展示运单的各类信息
// 当识别到地址、电话字段时，会显示复制图标
class InfoCard extends StatelessWidget {
  final String title;
  final Map<String, dynamic> infoMap;

  const InfoCard({Key? key, required this.title, required this.infoMap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<MapEntry<String, dynamic>> infoMapList = infoMap.entries.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != '')
          Text(title,
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w700, color: C.g33)),
        const SizedBox(height: 8),
        Column(
            children: infoMapList.map((info) {
          String key = info.key;
          dynamic value = info.value;
          bool canCopy = canCopyList.contains(key) && value != null;
          bool isTel = isTelList.contains(key) && value != null;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                key.tr,
                style: TextStyle(
                    color: C.g5c, fontSize: 12, fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  Expanded(
                      child: isTel
                          ? InkWell(
                              onTap: () async {
                                final Uri launchUri = Uri(
                                  scheme: 'tel',
                                  path: value,
                                );
                                try {
                                  bool canLaunch =
                                      await canLaunchUrl(launchUri);
                                  if (canLaunch) {
                                    await launchUrl(launchUri);
                                  }
                                } catch (e) {
                                  rethrow;
                                }
                              },
                              child: SizedBox(
                                  child: Text(
                                '$value',
                                softWrap: true,
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                    color: C.blue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              )),
                            )
                          : SizedBox(
                              child: Text('${value ?? '-'}',
                                  style: TextStyle(
                                      color: C.g33,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  maxLines: null,
                                  overflow: TextOverflow.visible,
                                  softWrap: true))),
                  if (canCopy)
                    InkWell(
                      onTap: () {
                        FlutterClipboard.copy(value).then((v) {
                          Toast.success('copySuccess'.tr);
                        });
                      },
                      child: SizedBox(
                        width: 24,
                        child: Icon(Icons.copy_all_outlined, color: C.primary),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          );
        }).toList()),
        // const SizedBox(height: 24),
      ],
    );
  }
}
