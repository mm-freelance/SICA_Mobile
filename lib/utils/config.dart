import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sica/theme/theme.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DialogHelp {
  //late BuildContext dialogContext;
  static void showLoading(BuildContext? context) {
    showDialog(
      context: context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(50)),
              width: 50.h,
              height: 50.h,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: CupertinoActivityIndicator(
                    color: AppTheme.primaryColor, radius: 14),
              ),
            ),
          ],
        );
      },
    );
  }

  void hideLoading(BuildContext? context) {
    Navigator.pop(context!);
  }

  static void showErroDialog(
      {String title = 'Error', String? description = 'Something went wrong'}) {
    Fluttertoast.showToast(
        msg: "Invalid Credentials",
        backgroundColor: Colors.red,
        
        gravity: ToastGravity.TOP,
        textColor: Colors.white);
  }
}
