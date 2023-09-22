import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/views/gft_bottom_navigation_bar.dart';
import '/data/controller/bottom_navigation.dart';
import '../../components/small_card_button.dart';
import '/components/basic/text.dart';
import '/components/basic/long_rect_button.dart';
import '/config/color.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<StatefulWidget> createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  final BottomNavController bCtl = Get.put(BottomNavController());

  @override
  Widget build(BuildContext context) {
    Image enrollIcon =
        Image.asset('assets/images/lunch.png', width: 40, height: 40);
    Image deliveryIcon =
        Image.asset('assets/images/glass.png', width: 40, height: 40);

    Widget top = Container(
        height: 200,
        decoration: BoxDecoration(
          color: C.blue,
        ),
        child: Row(
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              InkWell(
                  onTap: () {
                    bCtl.switchIndex(2);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 16, top: 48),
                    child: const CircleAvatar(
                        radius: 32,
                        backgroundImage:
                            AssetImage('assets/images/avatar.png')),
                  ))
            ]),
            Flexible(
                child: InkWell(
                    onTap: () {},
                    child: Container(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "some thing to display".tr,
                              style: TextStyle(
                                  color: C.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        )))),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset('assets/images/home_pic1.png', width: 160)
              ],
            )
          ],
        ));

    Widget middle = Container(
        padding: const EdgeInsets.only(top: 12),
        child: Center(
            child: Wrap(alignment: WrapAlignment.start, children: [
          SmallCardButton(
              onTap: () async {}, text: "Menu 1".tr, icon: enrollIcon),
          SmallCardButton(
              onTap: () async {}, text: "Menu 2".tr, icon: deliveryIcon)
        ])));

    Widget bottom = Expanded(
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.zero,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: C.gee, width: 1),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          BoldText('Some Index'.tr),
                          Expanded(child: Container()),
                          SmallText("${'Last Update'.tr} 15:00:05"),
                          InkWell(
                            onTap: () {},
                            child: Icon(Icons.refresh_outlined,
                                color: C.blue, size: 18),
                          )
                        ],
                      ),
                      const SizedBox(height: 24),
                      const SuperLargeText('67.3%'),
                      const SizedBox(height: 12),
                      LinearProgressIndicator(
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation(C.blue),
                        borderRadius: BorderRadius.circular(5),
                        minHeight: 10,
                        value: 0.673,
                      ),
                      const SizedBox(height: 12),
                      SmallText('some text'.tr),
                      const SizedBox(height: 24),
                      InkWell(
                          onTap: () {
                            bCtl.switchIndex(1);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'See All Data'.tr,
                                style: TextStyle(
                                    color: C.primary,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                LongRectButton(
                    text: 'Some data index'.tr,
                    imageIcon: Image.asset('assets/images/glass.png',
                        width: 24, height: 24),
                    onTap: () {
                      bCtl.switchIndex(1);
                    })
              ])),
    );
    return Scaffold(
      body: Container(
          color: C.gf9,
          child: Column(
            children: [top, middle, bottom],
          )),
      bottomNavigationBar: const GftBottomNavigationBar(),
    );
  }
}
