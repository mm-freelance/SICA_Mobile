import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sica/services/auth_repo.dart';
import 'package:sica/utils/config.dart';
import 'package:sica/views/login/otp_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/buton.dart';
import '../../components/input_feild.dart';
import '../../theme/theme.dart';
import '../../utils/images.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key, required this.accountType});
  final int accountType;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final memberId = TextEditingController();

  final mobile = TextEditingController();
  final name = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // login() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString("memberid", memberId.text.toString());
  //   prefs.setString("mobile", mobile.text.toString());
  //   prefs.setString("accounttype", widget.accountType.toString());
  //   Navigator.push(
  //                       context,
  //                       MaterialPageRoute(
  //                         builder: (context) => OtpScreen(
  //                           access_token:
  //                               '8f764f8b-7b19-4999-bfb8-49c391656a45',
  //                           accountType: widget.accountType,
  //                           mobile: '9655558329',
  //                         ),
  //                       ),
  //                     );
  // }

  void submit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_formKey.currentState!.validate()) {
      DialogHelp.showLoading(context);
      final service = AuthService();
      service
          .login(mobile.text, memberId.text,
              widget.accountType == 1 ? "MEMBER" : "GUEST",name.text)
          .then((value) {
        DialogHelp().hideLoading(context);
        if (value.isNotEmpty) {
          if (value[0]["error"] == null) {
            prefs.setString("memberid", memberId.text.toString());
            prefs.setString("mobile", mobile.text.toString());
            prefs.setString("accounttype", widget.accountType.toString());
            //prefs.setString(
            //    "access_token", value[0]["access_token"].toString());
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OtpScreen(
                  accountType: widget.accountType,
                  access_token: value[0]["access_token"].toString(),
                  mobile: mobile.text, name: name.text,
                ),
              ),
            );
          } else {
            Fluttertoast.showToast(
                msg: "Invalid Credentials",
                backgroundColor: Colors.red,
                gravity: ToastGravity.TOP,
                textColor: Colors.white);
          }
        } else {
          Fluttertoast.showToast(
              msg: "Invalid Credentials",
              backgroundColor: Colors.red,
              gravity: ToastGravity.TOP,
              textColor: Colors.white);
        }
        // DialogHelp.showErroDialog();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        titleSpacing: 0,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
        elevation: 0,
        title: Text(widget.accountType == 1 ? "Member Login" : "Guest Login"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              Center(
                child: Image.asset(
                  Images.logo2,
                  fit: BoxFit.cover,
                  width: 180.w,
                ),
              ),
              SizedBox(height: 30.h),
              if (widget.accountType == 1)
                Text(
                  "Membership number",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              if (widget.accountType == 1) SizedBox(height: 5.h),
              if (widget.accountType == 1)
                MyTextField(
                    textEditingController: memberId,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Membership Number";
                      }
                      return null;
                    },
                    labelText: "",
                    float: FloatingLabelBehavior.always,
                    hintText: "Membership Number",
                    color: const Color(0xff585A60)),
                     if (widget.accountType != 1)
              SizedBox(height: 15.h),
              if (widget.accountType != 1)
                Text(
                  "Name",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              if (widget.accountType != 1) SizedBox(height: 5.h),
              if (widget.accountType != 1)
                MyTextField(
                    textEditingController: name,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Name";
                      }
                      return null;
                    },
                    labelText: "",
                    float: FloatingLabelBehavior.always,
                    hintText: "Enter Name",
                    color: const Color(0xff585A60)),
              SizedBox(height: 15.h),
              Text(
                "Mobile Number",
                style: Theme.of(context).textTheme.labelSmall,
              ),
              SizedBox(height: 5.h),
              MyTextField(
                  textEditingController: mobile,
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Mobile Number";
                    }
                    return null;
                  },
                  labelText: "",
                  float: FloatingLabelBehavior.always,
                  hintText: "Mobile number",
                  color: const Color(0xff585A60)),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.h),
                child: RoundedButton(
                    ontap: () {
                      submit();
                    },
                    title: "Continue",
                    color: Theme.of(context).primaryColor,
                    textcolor: AppTheme.darkTextColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
