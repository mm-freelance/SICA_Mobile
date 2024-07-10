import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sica/services/auth_repo.dart';
import 'package:sica/utils/config.dart';
import 'package:sica/views/home/dashboard.dart';
import '../../components/buton.dart';
import '../../theme/theme.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({super.key, required this.access_token, required this.mobile, required this.accountType, required this.name});
   String access_token;
  final String mobile;
    final String name;
  final int accountType;
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _OTPformKey = GlobalKey<FormState>();

  bool isEmail = true;

  bool? _autoValidate = false;
  final otp = TextEditingController();
  SmartAuth? _smartAuth;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      _smartAuth = SmartAuth();
      getsms();
    
  }
  void getsms() async{
     final res = await _smartAuth!.getAppSignature();
      debugPrint('Pinput: App Signature for SMS Retriever API Is: $res');
  }
  void _submit() async {
    if (_OTPformKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
   
      DialogHelp.showLoading(context);
      final service = AuthService();
      service
          .otpVerify(
        widget.access_token,
        otp.text,
      )
          .then((value) {
        DialogHelp().hideLoading(context);
        if (value.isNotEmpty) {
          if (value[0]["error"] == null) {
            prefs.setString(
                "access_token", value[0]["access_token"].toString());
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        MyDashBoard(currentIndex: 0)),
                (_) => false);
          } else {
            Fluttertoast.showToast(
                msg: "Invalid OTP",
                backgroundColor: Colors.red,
                gravity: ToastGravity.TOP,
                textColor: Colors.white);
          }
        } else {
          Fluttertoast.showToast(
              msg: "Invalid OTP",
              backgroundColor: Colors.red,
              gravity: ToastGravity.TOP,
              textColor: Colors.white);
        }
        // DialogHelp.showErroDialog();
      });
    } else {
    
    }
  }
void resendOtp() async {
  otp.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
     var memberid=   prefs.getString("memberid");
     var mobile=       prefs.getString("mobile");
      DialogHelp.showLoading(context);
      final service = AuthService();
      service
          .login(mobile.toString(), memberid.toString(),
              widget.accountType == 1 ? "MEMBER" : "GUEST",widget.name)
          .then((value) {
        DialogHelp().hideLoading(context);
        if (value.isNotEmpty) {
          if (value[0]["error"] == null) {
             widget.access_token= value[0]["access_token"].toString();
          Fluttertoast.showToast(
                msg: "Otp Send Successfully",
                backgroundColor: Colors.green,
                gravity: ToastGravity.CENTER,
                textColor: Colors.white);
          } else {
            Fluttertoast.showToast(
                msg: "Something went wrong",
                backgroundColor: Colors.red,
                gravity: ToastGravity.TOP,
                textColor: Colors.white);
          }
        } else {
          Fluttertoast.showToast(
              msg:"Something went wrong",
              backgroundColor: Colors.red,
              gravity: ToastGravity.TOP,
              textColor: Colors.white);
        }
        // DialogHelp.showErroDialog();
      });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back)),
          elevation: 0,
          title: Text("OTP Verification"),
        ),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              Form(
                  key: _OTPformKey,
                  autovalidateMode: _autoValidate == true
                      ? AutovalidateMode.always
                      : AutovalidateMode.disabled,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Enter the OTP that we sent to +91 ${widget.mobile}",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      SizedBox(height: 30.h),
                      Center(
                        child: Pinput(
                          androidSmsAutofillMethod:  AndroidSmsAutofillMethod.smsUserConsentApi,
                          controller: otp,
                          listenForMultipleSmsOnAndroid: true,
                          length: 4,
                          autofocus: true,
                          forceErrorState: true,
                          onCompleted: (pin) => print(pin),
                          defaultPinTheme: PinTheme(
                            width: 38.h,
                            margin: EdgeInsets.only(right: 12.w),
                            height: 38.h,
                            textStyle:
                                TextStyle(fontSize: 18, color: Colors.white),
                            decoration: BoxDecoration(
                              // color: Color(0xFFFFFFFF),
                              border: Border.all(
                                  color: Color(0xFFB7BFC7), width: 1),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          pinputAutovalidateMode:
                              PinputAutovalidateMode.onSubmit,
                          validator: (pin) {
                            if (pin!.length >= 4) return null;
                            return 'Enter  OTP';
                          },
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Didn't get the code? ",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(fontSize: 12),
                          ),
                          GestureDetector(
                              onTap: () {resendOtp();},
                              child: Text("Resend",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: Colors.blue,
                                      )))
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 50.h, bottom: 20.h, left: 10, right: 10),
                        child: RoundedButton(
                          ontap: () {
                            _submit();
                          },
                          textcolor: const Color(0xFFFFFFFF),
                          title: "Submit",
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          textScaleFactor:
                              MediaQuery.of(context).textScaleFactor,
                          text: TextSpan(
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(fontSize: 10),
                            children: const <TextSpan>[
                              TextSpan(
                                text: 'By continuing, you agree to our ',
                              ),
                              TextSpan(
                                  text: 'Terms of use & Privacy Policy',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ));
  }
}
