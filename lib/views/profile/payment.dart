import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sica/services/event_repo.dart';
import 'package:sica/services/member_repo.dart';
import 'package:sica/views/home/dashboard.dart';
import 'package:sica/views/profile/payment_success.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../theme/theme.dart';
import '../../utils/config.dart';
import '../events/event_book.dart';

class MakePayment extends StatefulWidget {
  const MakePayment(
      {Key? key,
      required this.url,
      required this.callBackurl,
      required this.type,
      required this.eventid})
      : super(key: key);
  final String url;
  final int type;
  final int eventid;
  final String callBackurl;
  @override
  State<MakePayment> createState() => _MainPageState();
}

class _MainPageState extends State<MakePayment> {
  late WebViewController _controller; // Declare the WebViewController
  bool _isLoading = true; // To track loading state

  bool showFloat = false;
  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    loadurl();
    if (widget.type == 1) {
      getPayments();
    }
  }

  List paymentDetils = [];

  void getPayments() {
    final service = MemberRepo();
    service.getPayments().then((value) {
      if (value.isNotEmpty) {
        paymentDetils = value[0];

        if (mounted) setState(() {});
      }
    });
  }

  loadurl() {
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
      WebKitWebViewController(params)
          .setAllowsBackForwardNavigationGestures(true);
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }
    WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    controller
      ..enableZoom(true)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            const LoadingPage();
            // Update loading bar.
          },
          onPageStarted: (String url) {
            if (this.mounted) {
              setState(() {
                // if (widget.url.toString() == widget.url.toString()) {
                _isLoading = true; // Show loader when page starts loading
                // }
              });
            }
          },
          onPageFinished: (String url) {
            if (this.mounted) {
              setState(() {
                _isLoading = false; // Hide loader when page finishes loading
              });
            }
          },
          onNavigationRequest: (NavigationRequest request) async {
            print("launchaa" + request.url);
            if (request.url.contains("orderStatus=FAILED")) {
              print("FAILED" + request.url);
              //  Navigator.pushReplacement(
              //       context,
              //       MaterialPageRoute(
              //           builder: (BuildContext context) => TransactionStatus(type: 2,)),

              //       );
              // flutter: launchaahttps://www.codingcrown.com/?razorpay_payment_id=pay_N5Ahv1uI5SB3S1&razorpay_payment_link_id=plink_N5Ag0kOnHScGHZ&razorpay_payment_link_reference_id=&razorpay_payment_link_status=paid&razorpay_signature=0cbe8ea4b70489ab4a2829f8a90b26858b198aaf66455e533a06f0e51ed1692d
              return NavigationDecision.prevent;
            } else if (request.url
                .contains("razorpay_payment_link_status=paid")) {
              print("Success" + request.url);
              if (widget.type == 2) {
                final service = Eventrepo();
                DialogHelp.showLoading(context);
                service
                    .verifyEvent("Booked", widget.eventid, "Paid")
                    .then((value) {
                  DialogHelp().hideLoading(context);
                  if (value.isNotEmpty) {
                    List res = value;
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => EventBook()),
                        (_) => false);
                  } else {
                    Fluttertoast.showToast(
                        msg: "Something went wrong",
                        backgroundColor: Colors.red,
                        gravity: ToastGravity.TOP,
                        textColor: Colors.white);
                  }
                });
              }

              return NavigationDecision.prevent;
            } else if (request.url.startsWith('tel:') ||
                request.url.startsWith('whatsapp:') ||
                request.url.startsWith('fb:') ||
                request.url.startsWith('tg:')) {
              if (await canLaunch(request.url)) {
                await launch(request.url);
              }
              return NavigationDecision.prevent;
            } else {
              return NavigationDecision.navigate;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url.toString()));
    _controller = controller;
  }

  DateTime? lastBackPressedTime;

  @override
  Widget build(BuildContext context) {
    return buildWillPopScope();
  }

  int index = 0;
  bool onWillPop = false;
  late DateTime currentBackPressTime;
  buildWillPopScope() {
    return WillPopScope(
      onWillPop: () async {
        if (await _controller.canGoBack()) {
          _controller.goBack();

          return false;
        }
        // Stay App
        else {
          return true;
        }

        // if (await controller.canGoBack()) {
        //   print("onwill goback");
        //   controller.goBack();
        //   return Future.value(true);
        // } else {
        //   print("onwill not");

        //   return Future.value(false);
        // }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.3,
          leading: GestureDetector(
              onTap: () {
                if (this.mounted) {
                  setState(() {
                    showFloat = false;
                    if (widget.type == 1) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => MyDashBoard(
                                    currentIndex: 2,
                                  )),
                          ModalRoute.withName(
                              '/') // Replace this with your root screen's route name (usually '/')
                          );
                    } else {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => MyDashBoard(
                                    currentIndex: 1,
                                  )),
                          ModalRoute.withName(
                              '/') // Replace this with your root screen's route name (usually '/')
                          );
                    }
                  });
                }
              },
              child: Icon(Icons.arrow_back_ios_new)),
          actions: [
            if (widget.type == 1)
              IconButton(
                  onPressed: () {
                    showModal2(context);
                  },
                  icon: Icon(Icons.info_outline_rounded))
          ],
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
        // floatingActionButton: FloatingActionButton.small(
        //   shape: const CircleBorder(),
        //   // isExtended: true,
        //   child: Icon(
        //     Icons.close,
        //     color: Colors.white,
        //   ),
        //   backgroundColor: Colors.red,
        //   onPressed: () {
        //     if (this.mounted) {
        //       setState(() {
        //         showFloat = false;
        //         if (widget.type == 1) {
        //           Navigator.pushAndRemoveUntil(
        //               context,
        //               MaterialPageRoute(
        //                   builder: (BuildContext context) => MyDashBoard(
        //                         currentIndex: 3,
        //                       )),
        //               ModalRoute.withName(
        //                   '/') // Replace this with your root screen's route name (usually '/')
        //               );
        //         } else {
        //           Navigator.pushAndRemoveUntil(
        //               context,
        //               MaterialPageRoute(
        //                   builder: (BuildContext context) => MyDashBoard(
        //                         currentIndex: 1,
        //                       )),
        //               ModalRoute.withName(
        //                   '/') // Replace this with your root screen's route name (usually '/')
        //               );
        //         }
        //       });
        //     }
        //   },
        // ),
        body: Stack(
          children: [
            if (widget.type == 1)
              SafeArea(
                child: paymentDetils.isNotEmpty
                    ? paymentDetils[0]["is_member_debar"]
                        ? Center(
                            child: Text("Please Contact your adminstrator"),
                          )
                        : WebViewWidget(
                            controller: _controller,
                          )
                    : const Center(child: CircularProgressIndicator()),
              )
            else
              SafeArea(
                  child: WebViewWidget(
                controller: _controller,
              )),
            if (_isLoading)
              const Center(
                child: LoadingPage(), // Loader widget
              ),
          ],
        ),
      ),
    );
  }

  void showModal2(context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) {
          return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (() {
                Navigator.of(context).pop();
              }),
              child: SingleChildScrollView(
                child: paymentDetils.isNotEmpty
                    ? Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.0.r),
                            topRight: Radius.circular(12.0.r),
                          ),
                          color: Theme.of(context).cardColor,
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: 20.w,
                              left: 20.w,
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10.h,
                                ),
                                Center(
                                  child: Container(
                                    width: 40.w,
                                    height: 4.h,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[600],
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12.h),
                                  child: Text(
                                    "Subscription Fee details",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(fontSize: 16),
                                  ),
                                ),
                                 SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Paid Till:",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge!
                                          .copyWith(fontSize: 16),
                                    ),
                                    Text(
                                      "${paymentDetils[0]["paid_till"]}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge!
                                          .copyWith(fontSize: 16),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "YEAR",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge!
                                          .copyWith(fontSize: 16),
                                    ),
                                    Text(
                                      "SICA",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge!
                                          .copyWith(fontSize: 16),
                                    ),
                                    Text(
                                      "CBT",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge!
                                          .copyWith(fontSize: 16),
                                    ),
                                    Text(
                                      "TOTAL",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge!
                                          .copyWith(fontSize: 16),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                for (var video in paymentDetils[0]
                                    ["subscription_years"])
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(video["year"].toString(),
                                              style: GoogleFonts.montserrat(
                                                fontSize: 15,
                                                color: Colors.green,
                                                fontWeight: FontWeight.w600,
                                              )),
                                          Text(video["sica_fee"].toString(),
                                              style: GoogleFonts.montserrat(
                                                fontSize: 15,
                                                color: Colors.green,
                                                fontWeight: FontWeight.w600,
                                              )),
                                          Text(video["cbt_amount"].toString(),
                                              style: GoogleFonts.montserrat(
                                                fontSize: 15,
                                                color: Colors.green,
                                                fontWeight: FontWeight.w600,
                                              )),
                                          Text(
                                              video["subscription_amount"]
                                                  .toString(),
                                              style: GoogleFonts.montserrat(
                                                fontSize: 15,
                                                color: Colors.green,
                                                fontWeight: FontWeight.w600,
                                              )),
                                        ]),
                                  ),
                             
                                Divider(
                                  color: AppTheme.hintTextColor,
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total Fee:",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge!
                                          .copyWith(fontSize: 16),
                                    ),
                                    Text(
                                      "${paymentDetils[0]["subscription_total_fee"]}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge!
                                          .copyWith(fontSize: 16),
                                    ),
                                  ],
                                ),
                               if (paymentDetils[0]["convience_fee"] != "")
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Convenience Fee:",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge!
                                          .copyWith(fontSize: 16),
                                    ),
                                    Text(
                                      "${paymentDetils[0]["convience_fee"]}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge!
                                          .copyWith(fontSize: 16),
                                    ),
                                  ],
                                ),
                                if (paymentDetils[0]["gateway_note"] != "")
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                if (paymentDetils[0]["gateway_note"] != "")
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Payment Gateway note:",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge!
                                            .copyWith(fontSize: 16),
                                      ),
                                      Text(
                                        "${paymentDetils[0]["gateway_note"]}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge!
                                            .copyWith(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Penalty:",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge!
                                          .copyWith(fontSize: 16),
                                    ),
                                    Text(
                                      "${paymentDetils[0]["penalty_fee"]}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge!
                                          .copyWith(fontSize: 16),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total Payment:",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge!
                                          .copyWith(fontSize: 16),
                                    ),
                                    Text(
                                      "${paymentDetils[0]["total_fee"]}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge!
                                          .copyWith(fontSize: 16),
                                    ),
                                  ],
                                ), SizedBox(
                                  height: 30,
                                ),
                              ]),
                        ),
                      )
                    : CircularProgressIndicator(),
              ));
        });
  }
}

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.red,
        ),
      ),
    );
  }
}
