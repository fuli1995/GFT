import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '/config/color.dart';

class Option {
  final VoidCallback? onPressed;
  final String? text;
  final Widget? child;

  Option({this.onPressed, this.text, this.child});
}

// 弹出式底部按钮组
class BottomSheetButton extends StatefulWidget {
  final List<Option> optionList;

  final Widget child;

  const BottomSheetButton({
    Key? key,
    required this.optionList,
    required this.child,
  }) : super(key: key);
  @override
  State<BottomSheetButton> createState() => _BottomSheetButtonState();
}

class _BottomSheetButtonState extends State<BottomSheetButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) => CupertinoActionSheet(
            // title: const Text('Title'),
            // message: const Text('Message'),
            actions: [
              for (final option in widget.optionList)
                CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(context);
                    if (option.onPressed != null) {
                      option.onPressed!();
                    }
                  },
                  child: option.child ??
                      Text(
                        option.text!,
                        style: TextStyle(fontSize: 16, color: C.black),
                      ),
                ),
            ],
            cancelButton: CupertinoActionSheetAction(
              // isDestructiveAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'cancel'.tr,
                style: TextStyle(fontSize: 16, color: C.black),
              ),
            ),
          ),
        );

        // showModalBottomSheet<void>(
        //   context: context,
        //   useSafeArea: true,
        //   shape: const RoundedRectangleBorder(
        //     // side: BorderSide(),
        //     borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        //   ),
        //   builder: (BuildContext context) {
        //     return SafeArea(
        //         child: Container(
        //             child: Wrap(
        //       children: [
        //         for (final option in widget.optionList)
        //           Column(
        //             children: [
        //               InkWell(
        //                 child: Container(
        //                     height: 60,
        //                     width: double.infinity,
        //                     alignment: Alignment.center,
        //                     child: option.child ?? Text(option.text!)),
        //                 onTap: () {
        //                   Navigator.pop(context);

        //                   if (option.onPressed != null) {
        //                     option.onPressed!();
        //                   }
        //                 },
        //               ),
        //               const Divider(height: 1, color: Colors.grey),
        //             ],
        //           ),
        //         const SizedBox(height: 10),
        //         InkWell(
        //           child: Container(
        //               height: 60,
        //               alignment: Alignment.center,
        //               child: Text('cancel'.tr)),
        //           onTap: () {
        //             Navigator.pop(context);
        //           },
        //         ),
        //       ],
        //     )));
        //   },
        // );
      },
      child: widget.child,
    );
  }
}
