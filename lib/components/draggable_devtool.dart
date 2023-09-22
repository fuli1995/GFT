import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:clipboard/clipboard.dart';

import '/data/controller/devtool.dart';
import '/config/constants.dart';
import '/utilities/toast.dart';

class DraggableDevtool extends StatefulWidget {
  final Function onTap;

  const DraggableDevtool({super.key, required this.onTap});
  @override
  DraggableDevtoolState createState() => DraggableDevtoolState();
}

class DraggableDevtoolState extends State<DraggableDevtool> {
  final double _x = 10;
  final double _y = 50;
  final DevtoolController devC = Get.find();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width - 20;
    final double screenHeight = MediaQuery.of(context).size.height - 20;

    return Positioned(
        left: _x,
        bottom: _y,
        width: screenWidth,
        height: screenHeight - 100,
        child: Material(
          child: Container(
            width: double.infinity,
            height: screenHeight,
            decoration: BoxDecoration(
                // color: Colors.blue,
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1, color: Colors.green)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(width: 8),
                    const Text(
                      '${Config.env} Devtool',
                      style: TextStyle(color: Colors.green, fontSize: 18),
                    ),
                    Expanded(child: Container()),
                    IconButton(
                        onPressed: () {
                          devC.clearHttpInfoList();
                        },
                        icon: const Icon(Icons.delete_outline_outlined,
                            color: Colors.red, size: 24)),
                    IconButton(
                        onPressed: () {
                          widget.onTap();
                        },
                        icon: const Icon(Icons.minimize_rounded,
                            color: Colors.red, size: 24)),
                  ],
                ),
                SizedBox(
                    height: screenHeight - 160,
                    child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Obx(() => Column(
                                children: devC.httpInfoList.value.map((h) {
                              RxBool expanded = false.obs;
                              return Obx(() => Container(
                                    width: screenWidth,
                                    height: expanded.value ? null : 100,
                                    padding: const EdgeInsets.only(
                                        top: 4, bottom: 4),
                                    decoration: const BoxDecoration(
                                        border: Border.symmetric(
                                            horizontal: BorderSide(
                                                width: 0.5,
                                                color: Colors.red))),
                                    child: Column(
                                      children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    // todo: 提示会被挡住
                                                    FlutterClipboard.copy(h)
                                                        .then((v) {
                                                      Toast.success(
                                                          'copySuccess'.tr);
                                                    });
                                                  },
                                                  icon: const Icon(
                                                      Icons
                                                          .copy_all_outlined,
                                                      color: Colors.red,
                                                      size: 16)),
                                              IconButton(
                                                  onPressed: () {
                                                    expanded.value =
                                                        expanded.value
                                                            ? false
                                                            : true;
                                                  },
                                                  icon: expanded.value
                                                      ? const Icon(
                                                          Icons.expand_more,
                                                          color: Colors.red,
                                                          size: 16)
                                                      : const Icon(
                                                          Icons.expand_less,
                                                          color: Colors.red,
                                                          size: 16)),
                                            ]),
                                        Text(
                                          h,
                                          softWrap: true,
                                          maxLines:
                                              expanded.value ? null : 2,
                                          overflow: expanded.value
                                              ? null
                                              : TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.green),
                                        ),
                                      ],
                                    ),
                                  ));
                            }).toList())))),
              ],
            ),
          ),
        ));
  }
}
