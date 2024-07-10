import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sica/components/buton.dart';
import 'package:sica/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/images.dart';
import '../login/login.dart';

class AccountType extends StatefulWidget {
  AccountType({super.key});

  @override
  State<AccountType> createState() => _AccountTypeState();
}

class _AccountTypeState extends State<AccountType> {
  List accoutType = [
    "Guest",
    "SICA Member",
  ];

  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  "assets/images/background1.jpeg",
                ))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Container(
            //   foregroundDecoration: BoxDecoration(
            //     gradient: LinearGradient(
            //       colors: [
            //         Theme.of(context).scaffoldBackgroundColor,
            //         Colors.transparent,
            //         Colors.transparent,
            //         Theme.of(context).scaffoldBackgroundColor
            //       ],
            //       begin: Alignment.topCenter,
            //       end: Alignment.bottomCenter,
            //       stops: [0, 0, 0.8, 1],
            //     ),
            //   ),
            //   child: Image.asset(
            //     "assets/images/background4.jpeg",
            //     height: MediaQuery.of(context).size.height / 3.2,
            //     width: double.infinity,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            SizedBox(height: 200),
            Text(
              "Welcome To",
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontSize: 24),
            ),
            Center(
              child: Image.asset(
                Images.logo2,
                fit: BoxFit.cover,

                /// width: 130.w,
                height: 90.h,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.only(right: 12.w),
              child: Image.asset(
                "assets/images/camera3.png",
                height: 130.h,
                // width: 100,
                fit: BoxFit.cover,
              ),
            ),
             SizedBox(
              height: 50.h,
            ),
            // Image.asset(
            //   "assets/images/line2.jpeg",

            //   // width: 100,
            //   fit: BoxFit.cover,
            // ),
            // SizedBox(
            //   height: 10.h,
            // ),
            // ClipRRect(
            //   borderRadius: BorderRadius.all(Radius.circular(50)),
            //   child: Container(
            //       height: 40.h,

            //       decoration: BoxDecoration(
            //        // color: Colors.black,
            //         border: Border(
            //           top: BorderSide(
            //             color: AppTheme.primaryColor,
            //             width: 1.0, style: BorderStyle.solid,
            //           ),
            //           left: BorderSide(
            //             color: AppTheme.blackColor,
            //             width: 1.0, style: BorderStyle.solid,
            //           ),
            //           right: BorderSide(
            //             color: AppTheme.blackColor,
            //             width: 1.0, style: BorderStyle.solid,
            //           ),
            //           bottom: BorderSide(
            //             color: AppTheme.blackColor,
            //             width: 1.0, style: BorderStyle.solid,
            //           ),
            //         ),
            //       )),
            // ),
            // // Text(
            // //   "Southern India Cinematographers Association (SICA)",
            // //   style: Theme.of(context)
            // //       .textTheme
            // //       .headlineLarge!
            // //       .copyWith(fontSize: 16, height: 1.4),
            // //   textAlign: TextAlign.center,
            // // ),

            // Text(
            //   "Select Account Type",
            //   style: Theme.of(context)
            //       .textTheme
            //       .headlineLarge!
            //       .copyWith(fontSize: 18),
            // ),
            // SizedBox(
            //   height: 20.h,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: List.generate(
            //       accoutType.length,
            //       (index) => GestureDetector(
            //             onTap: () {
            //               setState(() {
            //                 _selectedIndex = index;
            //               });
            //             },
            //             child: AccountTypeCard(
            //                 index: index,
            //                 image: index == 0
            //                     ? "assets/images/2.png"
            //                     : "assets/images/1.png",
            //                 selectedIndex: _selectedIndex,
            //                 accoutType: accoutType),
            //           )),
            // ),
          //  Spacer(),
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                textScaleFactor: MediaQuery.of(context).textScaleFactor,
                text: TextSpan(
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontSize: 10),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'By continuing, you agree to our ',
                    ),
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launchUrl(Uri.parse(
                                "https://thesica.in/privacy-policy/"));
                          },
                        text: 'Terms of use & Privacy Policy',
                        style: TextStyle(decoration: TextDecoration.underline)),
                  ],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
              child: RoundedButton(
                  ontap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            LoginPage(accountType: _selectedIndex),
                      ),
                    );
                  },
                  title: "Sign In",
                  color: Theme.of(context).primaryColor,
                  textcolor: AppTheme.darkTextColor),
            ),
            SizedBox(
              height: 20.h,
            )
          ],
        ),
      ),
    );
  }
}

class AccountTypeCard extends StatelessWidget {
  AccountTypeCard({
    super.key,
    required int selectedIndex,
    required this.accoutType,
    required this.index,
    required this.image,
  }) : _selectedIndex = selectedIndex;

  final int _selectedIndex;
  final List accoutType;
  String image;
  int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112.h,
      width: 110.w,
      decoration: BoxDecoration(
        //  borderRadius: BorderRadius.circular(8),
        border: Border.all(
            width: 1.6,
            color: _selectedIndex == index
                ? Color.fromRGBO(236, 202, 117, 1)
                : Colors.grey),

        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(offset: Offset(0, 0), blurRadius: 1, color: Colors.black26)
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: Text(
              accoutType[index],
              style: GoogleFonts.roboto(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppTheme.whiteBackgroundColor,
              ),
            ),
          ),
          Image.asset(
            image,
            fit: BoxFit.cover,
            height: index == 1 ? 80.h : 55.h,
          ),
          if (index == 0)
            SizedBox(
              height: 6.h,
            ),
        ],
      ),
    );
  }
}
