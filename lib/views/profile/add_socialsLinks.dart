import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sica/components/buton.dart';
import 'package:sica/components/input_feild.dart';
import 'package:sica/services/member_repo.dart';
import 'package:sica/theme/theme.dart';
import 'package:sica/utils/config.dart';
import 'package:sica/views/home/dashboard.dart';

class SocialLinksPage extends StatefulWidget {
  SocialLinksPage(
      {super.key,
      required this.facebook,
      required this.insta,
      required this.youtube,
      required this.twiter,
      required this.imdb,
      required this.linkedin});
  final String facebook;
  final String insta;
  final String youtube;
  final String twiter;
  final String linkedin;
  final String imdb;

  @override
  State<SocialLinksPage> createState() => _SocialLinksPageState();
}

class _SocialLinksPageState extends State<SocialLinksPage> {
  // List socialLinksALL = [
  //   {"image": "facebook.png", "title": "Facebook", "id": "1"},
  //   {"image": "insta.png", "title": "Insta", "id": "2"},
  //   {"image": "youtube.png", "title": "youtube", "id": "3"},
  //   {"image": "twiter.png", "title": "twiter", "id": "4"},
  //   {"image": "linkedin.png", "title": "linkedin", "id": "5"},
  // ];
  List socialLinks = [
    {"image": "imbd.png", "title": "IMDB"},
    {"image": "facebook.png", "title": "Facebook"},
    {"image": "insta.png", "title": "Insta"},
    {"image": "youtube.png", "title": "youtube"},
    {"image": "twiter.png", "title": "twiter"},
    {"image": "imbd.png", "title": "IMDB"}
  ];
  @override
  void initState() {
    super.initState();
    getSocialLinks();
  }

  final facebookText = TextEditingController();
  final instaText = TextEditingController();
  final youtube = TextEditingController();
  final twiter = TextEditingController();
  final linkedin = TextEditingController();
  final imdb = TextEditingController();final formKey = GlobalKey<FormState>();
  void getSocialLinks() {
    facebookText.text = widget.facebook;
    instaText.text = widget.insta;
    youtube.text = widget.youtube;
    twiter.text = widget.twiter;
    linkedin.text = widget.linkedin;
    imdb.text = widget.imdb;
  }

  void submit() {
    final service = MemberRepo();
    DialogHelp.showLoading(context);
    service
        .addSocialLinks(imdb.text, facebookText.text, instaText.text,
            youtube.text, twiter.text, linkedin.text)
        .then((value) {
      DialogHelp().hideLoading(context);
      if (value.isNotEmpty) {
        Fluttertoast.showToast(
            msg: "Updated",
            backgroundColor: Colors.green,
            gravity: ToastGravity.TOP,
            textColor: Colors.white);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    MyDashBoard(currentIndex: 3)),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (() {
              Navigator.pop(context);
            })),
        titleSpacing: 2.w,
        title: Text(
          "Social Links",
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              // SizedBox(
              //   height: 30.h,
              // ),
              // Padding(
              //   padding: EdgeInsets.only(
              //       left: getProportionateScreenWidth(30),
              //       right: getProportionateScreenWidth(30)),
              //   child: InkWell(
              //     onTap: () {
              //       showModal(context);
              //     },
              //     child: Container(
              //         height: getProportionateScreenHeight(46),
              //         width: double.infinity,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(5),
              //           color: AppTheme.backGround2,
              //         ),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Text(
              //               "Select Social Link",
              //               style: TextStyle(
              //                   fontSize: 14,
              //                   color: Colors.black,
              //                   fontWeight: FontWeight.w500),
              //             )
              //           ],
              //         )),
              //   ),
              // ),
              SizedBox(
                height: 20.h,
              ),
              // ListView.builder(
              //   shrinkWrap: true,
              //   itemCount: socialLinks.length,
              //   itemBuilder: (context, index) {
              //     return Padding(
              //       padding:
              //           EdgeInsets.symmetric(vertical: 5.h, horizontal: 6.w),
              //       child: Row(
              //         children: [
              //           SizedBox(width: 10.w,),
              //           Container(
              //             height: 45.h,
              //             width: 45.w,
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(16),
              //               image: DecorationImage(
              //                 image: AssetImage(
              //                     "assets/images/${socialLinks[index]["image"]}"),
              //                 fit: BoxFit.cover,
              //               ),
              //             ),
              //           ),
              //           Expanded(
              //             child: Padding(
              //               padding: EdgeInsets.symmetric(
              //                 horizontal: 12.w,
              //               ),
              //               child: MyTextField(
              //                   // textEditingController: _controller.emailController,
        
              //                   hintText:
              //                       "Paste your ${socialLinks[index]["title"]} Link here",
              //                   color: const Color(0xff585A60)),
              //             ),
              //           ),
              //           // GestureDetector(
              //           //   onTap: () {
              //           //     socialLinks.removeAt(index);
              //           //     setState(() {});
              //           //   },
              //           //   child: Icon(
              //           //     Icons.close,
              //           //     color: AppTheme.hintTextColor,
              //           //     size: 26.h,
              //           //   ),
              //           // )
              //         ],
              //       ),
              //     );
              //   },
              // ),
              // Padding(
              //   padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 6.w),
              //   child: Row(
              //     children: [
              //       SizedBox(
              //         width: 10.w,
              //       ),
              //       Container(
              //         height: 45.h,
              //         width: 45.w,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(16),
              //           image: DecorationImage(
              //             image: AssetImage(
              //                 "assets/images/${socialLinks[0]["image"]}"),
              //             fit: BoxFit.cover,
              //           ),
              //         ),
              //       ),
              //       Expanded(
              //         child: Padding(
              //           padding: EdgeInsets.symmetric(
              //             horizontal: 12.w,
              //           ),
              //           child: MyTextField(
              //               textEditingController: imdb,validation: (value) {
              //                 String pattern =
              //                     r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)';
              //                 RegExp regexp = new RegExp(pattern);
              //                 if (value == null || value.isEmpty) {
              //                   return null;
              //                 } else if (!regexp.hasMatch(value)) {
              //                   return 'Please enter valid url';
              //                 }
              //                 return null;
              //               },
              //               hintText:
              //                   "Paste your ${socialLinks[0]["title"]} Link here",
              //               color: const Color(0xff585A60)),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 6.w),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10.w,
                    ),
                    Container(
                      height: 45.h,
                      width: 45.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/images/${socialLinks[1]["image"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                        ),
                        child: MyTextField(
                            textEditingController: facebookText,validation: (value) {
                              String pattern =
                                  r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)';
                              RegExp regexp = new RegExp(pattern);
                              if (value == null || value.isEmpty) {
                                return null;
                              } else if (!regexp.hasMatch(value)) {
                                return 'Please enter valid url';
                              }
                              return null;
                            },
                            hintText:
                                "Paste your ${socialLinks[1]["title"]} Link here",
                            color: const Color(0xff585A60)),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 6.w),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10.w,
                    ),
                    Container(
                      height: 45.h,
                      width: 45.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/images/${socialLinks[2]["image"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                        ),
                        child: MyTextField(
                            textEditingController: instaText,validation: (value) {
                              String pattern =
                                  r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)';
                              RegExp regexp = new RegExp(pattern);
                              if (value == null || value.isEmpty) {
                                return null;
                              } else if (!regexp.hasMatch(value)) {
                                return 'Please enter valid url';
                              }
                              return null;
                            },
                            hintText:
                                "Paste your ${socialLinks[2]["title"]} Link here",
                            color: const Color(0xff585A60)),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 6.w),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10.w,
                    ),
                    Container(
                      height: 45.h,
                      width: 45.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/images/${socialLinks[3]["image"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                        ),
                        child: MyTextField(
                            textEditingController: youtube,
                            validation: (value) {
                              String pattern =
                                  r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)';
                              RegExp regexp = new RegExp(pattern);
                              if (value == null || value.isEmpty) {
                                return null;
                              } else if (!regexp.hasMatch(value)) {
                                return 'Please enter valid url';
                              }
                              return null;
                            },
                            hintText:
                                "Paste your ${socialLinks[3]["title"]} Link here",
                            color: const Color(0xff585A60)),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 6.w),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10.w,
                    ),
                    Container(
                      height: 45.h,
                      width: 45.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/images/${socialLinks[4]["image"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                        ),
                        child: MyTextField(
                            textEditingController: twiter,validation: (value) {
                              String pattern =
                                  r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)';
                              RegExp regexp = new RegExp(pattern);
                              if (value == null || value.isEmpty) {
                                return null;
                              } else if (!regexp.hasMatch(value)) {
                                return 'Please enter valid url';
                              }
                              return null;
                            },
                            hintText:
                                "Paste your ${socialLinks[4]["title"]} Link here",
                            color: const Color(0xff585A60)),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 6.w),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10.w,
                    ),
                    Container(
                      height: 45.h,
                      width: 45.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/images/${socialLinks[5]["image"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                        ),
                        child: MyTextField(
                            textEditingController: linkedin,validation: (value) {
                              String pattern =
                                  r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)';
                              RegExp regexp = new RegExp(pattern);
                              if (value == null || value.isEmpty) {
                                return null;
                              } else if (!regexp.hasMatch(value)) {
                                return 'Please enter valid url';
                              }
                              return null;
                            },
                            hintText:
                                "Paste your ${socialLinks[5]["title"]} Link here",
                            color: const Color(0xff585A60)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 30.w, right: 20.w),
                child: RoundedButton(
                  ontap: () {
                    if(formKey.currentState!.validate()){
  submit();
                    }
                  
                  },
                  textcolor: const Color(0xFFFFFFFF),
                  title: "Save",
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(
                height: 36.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
