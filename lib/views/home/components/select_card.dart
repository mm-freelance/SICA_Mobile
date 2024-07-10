import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sica/theme/theme.dart';

class Choice {
  Choice({required this.title, required this.svg, required this.page});
  final String title;
  final String svg;
  Widget page;
}

class SelectCard extends StatelessWidget {
  const SelectCard({Key? key, required this.title, required this.svg})
      : super(key: key);
  final String title;
  final String svg;
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle =
        Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 13);
    return Container(
        // color: Color(0xFFFFEB3B),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Color.fromRGBO(205, 192, 158, 1),
          ),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (svg == "camera2")
                Icon(
                  Icons.photo_library_outlined,
                  color: Theme.of(context).primaryColor,
                )
              else
                SvgPicture.asset(
                  "assets/icons/$svg.svg",
                  height: 24.h,
                  color: Theme.of(context).primaryColor,
                ),
              SizedBox(
                height: 5.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child:
                    Text(title, style: textStyle, textAlign: TextAlign.center),
              ),
            ]));
  }
}
