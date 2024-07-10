import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/buton.dart';
import '../../theme/theme.dart';
import '../home/dashboard.dart';

class EventBook extends StatelessWidget {
  EventBook({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: SvgPicture.asset(
              "assets/images/success.svg",
              height: 150.h,
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Text(
            "Event Enrolled Successfully",
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontSize: 20, color: Colors.blueAccent),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 60.h,
              bottom: 20.h,
              left: 20.w,
              right: 20.w,
            ),
            child: RoundedButton(
              ontap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            MyDashBoard(currentIndex: 1)),
                    (_) => false);
              },
              textcolor: const Color(0xFFFFFFFF),
              title: "Continue",
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
