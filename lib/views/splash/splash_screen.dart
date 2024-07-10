import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sica/views/account_type.dart/account_type.dart';
import 'package:sica/views/home/dashboard.dart';
import '../../utils/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
   show();
  }
  void show() {
    
    Timer(const Duration(seconds: 2), () async{
       SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getString("access_token") != "" && prefs.getString("access_token") != null) {
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    MyDashBoard(currentIndex: 0)),
            (_) => false);
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => AccountType()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: Colors.white,
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(58.0),
        child: Image.asset(
          Images.logo2,
          height: 100.h,
        ),
      )),
    );
  }
}
