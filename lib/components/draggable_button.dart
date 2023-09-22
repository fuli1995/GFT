import 'package:flutter/material.dart';

class DraggableButton extends StatefulWidget {
  final Function onTap;

  const DraggableButton({super.key, required this.onTap});
  @override
  DraggableButtonState createState() => DraggableButtonState();
}

class DraggableButtonState extends State<DraggableButton> {
  double _x = 20;
  double _y = 150;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: _x,
        top: _y,
        child: Material(
            // color: Colors.transparent,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(width: 1, color: Colors.red)),
              child: InkWell(
                  onTap: () {
                    widget.onTap();
                  },
                  child: Draggable(
                    feedback: const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.transparent,
                      child: Icon(Icons.developer_mode_outlined,
                          color: Colors.transparent),
                    ),
                    child: const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.developer_mode_outlined,
                          color: Colors.red),
                    ),
                    onDragUpdate: (details) {
                      double x = details.globalPosition.dx - 30;
                      double y = details.globalPosition.dy - 30;

                      // todo:四个边界都要限制
                      if (x > 30 && y > 30) {
                        setState(() {
                          _x = x;
                          _y = y;
                        });
                      }
                    },
                  )),
            )));
  }
}
