import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sica/views/home/history.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/images.dart';

class AboutSica extends StatelessWidget {
  const AboutSica({super.key});
  launchURLMethod(String link) async {
    final Uri url = Uri.parse(link);
    try {
        if (!await launchUrl(url,mode: LaunchMode.inAppBrowserView)) {
      throw Exception('Could not launch $url');
    }
    // ignore: empty_catches
    } catch (e) {
      print(e);
    }
  
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
            child: const Icon(Icons.arrow_back)),
        elevation: 0.1,
        title: const Text("About"),
      ),
      body: Container(
          // padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
          margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
          // decoration: BoxDecoration(
          //     color: Theme.of(context).cardColor,
          //     borderRadius: BorderRadius.circular(8),
          //     border:
          //         Border.all(color: Colors.grey.withOpacity(0.4), width: 1)),
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  Images.logo2,
                  fit: BoxFit.cover,
                  width: 180.w,
                ),
              ),
              SizedBox(height: 30.h),
              Text(
                "The Southern India Cinematographers Association, SICA, was started on 27th November 1972. Mr. A. Vincent was the Founder-President, Mr.P.N.Sundaram the General Secretary and Mr. S. Maruthi Rao the Treasurer. SICA is a TRADE UNION of all South Indian Cinematographers and is affiliated to the Film Employees Federation of South India (FEFSI).",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(height: 1.3),
              ),
              SizedBox(height: 5.h),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => History()));
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 20.h, bottom: 6.h),
                  child: Row(
                    children: [
                      Icon(
                        Icons.history,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: Text(
                          "History of SICA",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 15),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12.h,
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                color: Color.fromRGBO(31, 94, 94, 94),
              ),
              GestureDetector(
                onTap: () {
                  launchURLMethod('https://thesica.in/current-body/');
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 10.h, bottom: 6.h),
                  child: Row(
                    children: [
                      Icon(
                        CupertinoIcons.news_solid,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: Text(
                          "Current Body",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 15),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12.h,
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                color: Color.fromRGBO(31, 94, 94, 94),
              ),
              GestureDetector(
                onTap: () {
                  launchURLMethod('https://thesica.in/593-2/');
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 10.h, bottom: 6.h),
                  child: Row(
                    children: [
                      Icon(
                        Icons.notes,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: Text(
                          "Previous Body",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 15),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12.h,
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                color: Color.fromRGBO(31, 94, 94, 94),
              ),
              GestureDetector(
                onTap: () {
                  launchURLMethod('https://thesica.in/themaster/');
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 10.h, bottom: 6.h),
                  child: Row(
                    children: [
                      Icon(
                        Icons.label_important,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: Text(
                          "The Master",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 15),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12.h,
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                color: Color.fromRGBO(31, 94, 94, 94),
              ),
              GestureDetector(
                onTap: () {
                  launchURLMethod('https://thesica.in/sica-awards-winners/');
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 10.h, bottom: 6.h),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/award.svg",
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: Text(
                          "Award Winners",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 15),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12.h,
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                color: Color.fromRGBO(31, 94, 94, 94),
              ),
            ],
          )),
    );
  }
}
