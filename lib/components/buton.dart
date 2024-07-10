import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class RoundedButton extends StatelessWidget {
  var ontap;
  String title;
  var color;
  var borderColor;
  var textcolor;
  int radius;
  double fontsize;
  FontWeight fontweigth;
  double height;
  RoundedButton(
      {super.key,
      required this.ontap,
      required this.title,
      required this.color,
      this.radius = 10,
      this.borderColor,
      this.height=50,
      this.fontweigth=FontWeight.w600,
      this.fontsize=16,
      required this.textcolor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
          height:height.h,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: borderColor==null? color: borderColor),
            color: color,
            borderRadius: BorderRadius.circular(radius.r),
          ),
          child: Center(
              child: Text(
            title,
            style: TextStyle(
                fontSize: fontsize, color: textcolor, fontWeight: fontweigth),
          ))),
    );
  }
}
