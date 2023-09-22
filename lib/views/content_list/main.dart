import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import '/views/gft_bottom_navigation_bar.dart';
import 'content_list.dart';
import '/config/color.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class Type {
  final String name;

  Type({required this.name});
}

class Tag extends StatelessWidget {
  final String title;
  final String type;
  final Function onTap;
  final bool focused;

  const Tag(
      {super.key,
      required this.title,
      required this.type,
      required this.onTap,
      this.focused = false});

  @override
  Widget build(BuildContext context) {
    final Color color = {
          "green": C.green,
          "red": C.lightRed,
          "blue": C.blue,
        }[type] ??
        C.grey;
    final themeData = Theme.of(context).chipTheme.copyWith(
          labelStyle: TextStyle(
              color: focused ? color : C.black,
              fontWeight: focused == true ? FontWeight.w700 : FontWeight.w500),
          side: BorderSide(
              color: focused ? color : C.ge9, width: focused ? 2 : 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36.0),
          ),
        );
    return Theme(
      data: Theme.of(context).copyWith(chipTheme: themeData),
      child: GestureDetector(
        onTap: onTap as void Function(),
        child: Chip(
          padding: const EdgeInsets.only(left: 2, right: 2),
          backgroundColor: Colors.white,
          avatar: type == 'grey'
              ? null
              : Icon(Icons.circle, color: color, size: 24),
          label: Text(
            title,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ),
    );
  }
}

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<StatefulWidget> createState() => ListScreenState();
}

class ListScreenState extends State<ListScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  //刷新列表
  Future<void> refresh() async {}

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // todo:在initState中setState操作会报错，这里延时执行
    Future.delayed(const Duration(milliseconds: 100), () {
      refresh();
    });
    Get.put<ListScreenState>(this); //用于后续用Getx调用fresh函数
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final RxString nowOrderType = 'type 1'.obs;

  Rx<SampleItem?> selectedMenu = Rx<SampleItem?>(SampleItem.itemOne);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: C.white,
          automaticallyImplyLeading: false,
          elevation: 0.2, // 设置AppBar的阴影高度
          shadowColor: C.white,
          toolbarHeight: 48, //写死高度才不会和tab bar有间距
          title: TabBar(
            controller: _tabController,
            labelColor: C.primary,
            indicatorColor: C.primary,
            dividerColor: Colors.transparent,
            tabs: <Widget>[
              Tab(
                text: 'View 1'.tr,
              ),
              Tab(
                text: 'View 2'.tr,
              ),
            ],
          ),
          actions: <Widget>[
            Obx(() => PopupMenuButton<SampleItem>(
                  icon: const Icon(Icons.more_vert_outlined),
                  surfaceTintColor: C.white,
                  initialValue: selectedMenu.value,
                  onSelected: (SampleItem item) {
                    selectedMenu.value = item;
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<SampleItem>>[
                    PopupMenuItem<SampleItem>(
                      value: SampleItem.itemOne,
                      child: Text('operation 1'.tr),
                    ),
                    PopupMenuItem<SampleItem>(
                      value: SampleItem.itemTwo,
                      child: Text('operation 1'.tr),
                    ),
                    PopupMenuItem<SampleItem>(
                      value: SampleItem.itemThree,
                      child: Text('operation 1'.tr),
                    ),
                  ],
                ))
          ]),
      backgroundColor: C.gf9,
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Column(
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Obx(() => Row(
                            children: [
                          Type(name: 'type 1'),
                          Type(name: 'type 2'),
                          Type(name: 'type 3'),
                          Type(name: 'type 4'),
                        ].map((type) {
                          return Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: Tag(
                              title: type.name,
                              onTap: () {
                                nowOrderType.value = type.name;
                                refresh();
                              },
                              type: {
                                    "type 1": "blue",
                                    "type 2": "red",
                                    "type 3": "green",
                                  }[type.name] ??
                                  'grey',
                              focused: type.name == nowOrderType.value,
                            ),
                          );
                        }).toList()))),
              ),
              Expanded(
                  child: RefreshIndicator(
                      onRefresh: refresh, child: ContentCardListPage()))
            ],
          ),
          const Center(
            child: Text("new function to be added."),
          ),
        ],
      ),
      bottomNavigationBar: const GftBottomNavigationBar(),
    );
  }
}
