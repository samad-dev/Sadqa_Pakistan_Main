import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  final String? text;
  final Color? buttonColor;
  final Color? borderColor;
  final Color? textColor;
  final Function? onTap;
  final double? buttonRadius;

  ButtonWidget(
      {required this.onTap,
      this.borderColor,
      Key? key,
      this.text,
      this.buttonColor,
      this.textColor,
      this.buttonRadius})
      : super(key: key);

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          side: BorderSide(
            // width: 5.0,
            color: widget.borderColor ?? Colors.white,
          ),
          minimumSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.052),
          primary: widget.buttonColor ?? Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.buttonRadius ??
                MediaQuery.of(context).size.width * 0.02),
          ),
        ),
        onPressed: () {
          widget.onTap;
        },
        child: Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.022,
              bottom: MediaQuery.of(context).size.height * 0.022),
          child: Text(
            widget.text!,
            style: TextStyle(
              color: widget.textColor ?? Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: MediaQuery.of(context).size.width * 0.035,
            ),
          ),
        ));
  }
}
