import 'package:flutter/material.dart';
import "package:url_launcher/url_launcher.dart";
import '/components/bottom_sheet_button.dart';

// 获取地址中的门牌号
String getHouseNo({String? fullAddress}) {
  String houseNo = '';
  String fA = fullAddress ?? '';
  RegExp regExp = RegExp(r'\b\d+(?:-\d+)*\b');
  Iterable<Match> matches = regExp.allMatches(fA);

  if (matches.isNotEmpty) {
    houseNo = matches.last.group(0)!;
    // print('Last Extracted: $houseNo');
  } else {
    // print('No matches found.');
  }
  return houseNo == '' ? fA : houseNo;
}

void openGoogleMapsNavigation(String address, {String type = 'google'}) async {
  // 将地址进行URL编码
  String encodedAddress = Uri.encodeComponent(address);

  Map uriMap = {
    "google": Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$encodedAddress'),
    "itsmo": Uri.parse('https://www.its-mo.com/maps/search/$encodedAddress/'),
  };
  Uri uri = uriMap[type];

  // 使用url_launcher插件打开URL
  bool canLaunch = await canLaunchUrl(uri);
  if (canLaunch) {
    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  } else {
    throw 'Can\'t open Maps';
  }
}

class AddressWrapper extends StatelessWidget {
  final String address;
  final Widget child;

  const AddressWrapper({super.key, required this.address, required this.child});
  @override
  Widget build(BuildContext context) {
    return BottomSheetButton(
      optionList: [
        Option(
            text: 'Google Map',
            onPressed: () {
              openGoogleMapsNavigation(address, type: 'google');
            }),
        Option(
            text: 'いつもNAVI',
            onPressed: () {
              openGoogleMapsNavigation(address, type: 'itsmo');
            }),
      ],
      child: child,
    );
  }
}
