import 'package:flutter/material.dart';
import 'package:gg_frontend/global_stuff/global_variables.dart';

class Own_Button_3 extends StatefulWidget {
  Widget? child;
  String text;
  Color? color;
  double width;
  double height;
  Function() onPressed;
  Own_Button_3({
    Key? key,
    this.child,
    this.text = "text",
    this.color,
    this.width = 150,
    this.height = 50,
    required this.onPressed,
  }) : super(key: key);

  @override
  _Own_Button_3State createState() => _Own_Button_3State();
}

class _Own_Button_3State extends State<Own_Button_3> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            backgroundColor:
                MaterialStateProperty.all(widget.color ?? global_color_1),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ))),
        onPressed: () {
          widget.onPressed();
        },
        child: Container(
          width: widget.width,
          height: widget.height,
          alignment: Alignment.center,
          child: widget.child ??
              Text(
                widget.text,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
        ));
  }
}
