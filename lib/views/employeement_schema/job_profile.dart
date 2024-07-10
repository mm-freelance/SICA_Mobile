import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sica/models/MemberDetailModel.dart';
import 'package:sica/models/PaymentResponse.dart';
import 'package:sica/services/member_repo.dart';
import 'package:sica/utils/config.dart';
import 'package:sica/views/profile/add_project.dart';
import 'package:sica/views/profile/add_work.dart';
import 'package:sica/views/profile/edit_profile.dart';
import 'package:sica/views/profile/payment.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../components/movie_card.dart';
import '../../theme/theme.dart';

class JobProfile extends StatefulWidget {
  JobProfile({super.key, required this.memberno});
final String memberno;
  @override
  State<JobProfile> createState() => _ProfileState();
}

class _ProfileState extends State<JobProfile> {
  List socialLinks = [
    {"image": "imbd.png", "title": "IMDB"},
    {"image": "facebook.png", "title": "Facebook"},
    {"image": "insta.png", "title": "Insta"},
    {"image": "youtube.png", "title": "youtube"},
    {"image": "twiter.png", "title": "twiter"},
    {"image": "imbd.png", "title": "IMDB"}
  ];

  List<MemberDetailModel>? memberDetails;

  @override
  void initState() {
    super.initState();
    getMemberDetails();
  }

  String? accountType;
  void getMemberDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    accountType = (sharedPreferences.getString('accounttype') ?? "");
    if (mounted) setState(() {});
    final service = MemberRepo();
    service.getMemberDetails(widget.memberno).then((value) {
      if (value.isNotEmpty) {
        memberDetails = value;
        if (mounted) setState(() {});
      }
    });
  }

  launchURLMethod(String link) async {
    final Uri url = Uri.parse(link);
    try {
      if (!await launchUrl(url)) {
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
      //backgroundColor: AppTheme.backGround2,
      appBar: AppBar(
        titleSpacing: 0,
      centerTitle: false,
        elevation: 1,
        title: Text("Job Profile"),
      ),
      body: accountType == "1"
          ? memberDetails != null
              ? SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (memberDetails![0]
                                    .memberBasicDetails!
                                    .image
                                    .toString() ==
                                "")
                              Container(
                                height: 140,
                                width: 120,
                                decoration: BoxDecoration(
                                  //  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/profile.jpeg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            else
                              Container(
                                height: 140,
                                width: 120,
                                decoration: BoxDecoration(
                                  //  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(memberDetails![0]
                                        .memberBasicDetails!
                                        .image
                                        .toString()),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        memberDetails![0]
                                            .memberBasicDetails!
                                            .name
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium!
                                            .copyWith(
                                              fontSize: 16,
                                            )),
                                    Divider(
                                      color: AppTheme.backGround2,
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    RichText(
                                      textScaleFactor: 1,
                                      text: TextSpan(
                                        text: '#',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(
                                              fontSize: 18,
                                            ),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text:
                                                  ' ${memberDetails![0].memberBasicDetails!.membershipNo.toString()}',
                                              style: TextStyle(
                                                fontSize: 16,
                                              )),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: AppTheme.backGround2,
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      memberDetails![0]
                                          .memberBasicDetails!
                                          .grade
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!
                                          .copyWith(
                                            fontSize: 16,
                                          ),
                                    ),
                                    Divider(
                                      color: AppTheme.backGround2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     RichText(
                        //       textScaleFactor: 1,
                        //       text: TextSpan(
                        //         text: ' #',
                        //         style: Theme.of(context)
                        //             .textTheme
                        //             .headlineSmall!
                        //             .copyWith(
                        //               fontSize: 18,
                        //             ),
                        //         children: <TextSpan>[
                        //           TextSpan(
                        //               text:
                        //                   '  ${memberDetails![0].memberBasicDetails!.membershipNo.toString()}',
                        //               style: TextStyle(
                        //                 fontSize: 14,
                        //               )),
                        //         ],
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       width: 80.w,
                        //     ),
                        //     Row(
                        //       children: [
                        //         Icon(
                        //           CupertinoIcons.calendar,
                        //           size: 22.h,
                        //         ),
                        //         Text(
                        //             ' ${memberDetails![0].memberBasicDetails!.joiningDate.toString()}',
                        //             style: Theme.of(context)
                        //                 .textTheme
                        //                 .headlineSmall!
                        //                 .copyWith(
                        //                   fontSize: 14,
                        //                 )),
                        //       ],
                        //     )
                        //   ],
                        // ),
                        SizedBox(
                          height: 25.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Contact no.",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!),
                            Text(
                              "${memberDetails![0].memberBasicDetails!.mobileNumber.toString()}",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        Divider(
                          color: AppTheme.backGround2,
                        ),
                        // SizedBox(
                        //   height: 25.h,
                        // ),
                        //  Text("Mail Id",
                        //     style: Theme.of(context).textTheme.headlineMedium!),
                        // SizedBox(
                        //   height: 6.h,
                        // ),
                        // Text(
                        //   "${memberDetails![0].memberBasicDetails!..toString()}",
                        //   style: Theme.of(context).textTheme.bodySmall,
                        // ),
                        if (memberDetails![0]
                                .memberBasicDetails!
                                .email
                                .toString() !=
                            "")
                          Padding(
                            padding: const EdgeInsets.only(top: 25, bottom: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Email",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!),
                                Text(
                                  "${memberDetails![0].memberBasicDetails!.email.toString()}",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        if (memberDetails![0]
                                .memberBasicDetails!
                                .email
                                .toString() !=
                            "")
                          Divider(
                            color: AppTheme.backGround2,
                          ),
                        if (memberDetails![0]
                                .memberBasicDetails!
                                .date_of_birth
                                .toString() !=
                            "")
                          Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("DOB",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!),
                                Text(
                                  "${memberDetails![0].memberBasicDetails!.date_of_birth.toString()}",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        if (memberDetails![0]
                                .memberBasicDetails!
                                .date_of_birth
                                .toString() !=
                            "")
                          Divider(
                            color: AppTheme.backGround2,
                          ),
                        if (memberDetails![0]
                                .memberBasicDetails!
                                .joiningDate
                                .toString() !=
                            "")
                          Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("DOJ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!),
                                Text(
                                  "${memberDetails![0].memberBasicDetails!.joiningDate.toString()}",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        if (memberDetails![0]
                                .memberBasicDetails!
                                .joiningDate
                                .toString() !=
                            "")
                          Divider(
                            color: AppTheme.backGround2,
                          ),
                        if (memberDetails![0]
                                .memberBasicDetails!
                                .portifolioLink
                                .toString() !=
                            "")
                          Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                launchURLMethod(memberDetails![0]
                                    .memberBasicDetails!
                                    .portifolioLink
                                    .toString());
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Portfolio Link",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Flexible(
                                    child: Text(
                                      "${memberDetails![0].memberBasicDetails!.portifolioLink.toString()}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(color: Colors.blue),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (memberDetails![0]
                                .memberBasicDetails!
                                .portifolioLink
                                .toString() !=
                            "")
                          Divider(
                            color: AppTheme.backGround2,
                          ),

                        Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: Text("About",
                              style:
                                  Theme.of(context).textTheme.headlineMedium!),
                        ),

                        if (memberDetails![0]
                                .memberBasicDetails!
                                .notes
                                .toString() !=
                            "")
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              "${memberDetails![0].memberBasicDetails!.notes.toString()}",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        if (memberDetails![0]
                                .memberBasicDetails!
                                .notes
                                .toString() !=
                            "")
                          Divider(
                            color: AppTheme.backGround2,
                          ),
                        SizedBox(
                          height: 26.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Socials Link",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!),
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),

                        SizedBox(
                          width: double.infinity,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //if (memberDetails![0]
                                  //   //       .memberBasicDetails!
                                  //       .imdb_link
                                  //       .toString() !=
                                  //   "")
                                  // Padding(
                                  //   padding: EdgeInsets.only(right: 20.w),
                                  //   child: GestureDetector(
                                  //     onTap: () {
                                  //       launchURLMethod(memberDetails![0]
                                  //           .memberBasicDetails!
                                  //           .imdb_link
                                  //           .toString());
                                  //     },
                                  //     child: SocialLinks(
                                  //         socialLinks: socialLinks[0]),
                                  //   ),
                                  // ),
                                  if (memberDetails![0]
                                          .memberBasicDetails!
                                          .facebookLink
                                          .toString() !=
                                      "")
                                    Padding(
                                      padding: EdgeInsets.only(right: 20.w),
                                      child: GestureDetector(
                                        onTap: () {
                                          launchURLMethod(memberDetails![0]
                                              .memberBasicDetails!
                                              .facebookLink
                                              .toString());
                                        },
                                        child: SocialLinks(
                                            socialLinks: socialLinks[1]),
                                      ),
                                    ),
                                  if (memberDetails![0]
                                          .memberBasicDetails!
                                          .instagramLink
                                          .toString() !=
                                      "")
                                    Padding(
                                      padding: EdgeInsets.only(right: 20.w),
                                      child: GestureDetector(
                                        onTap: () {
                                          launchURLMethod(memberDetails![0]
                                              .memberBasicDetails!
                                              .instagramLink
                                              .toString());
                                        },
                                        child: SocialLinks(
                                            socialLinks: socialLinks[2]),
                                      ),
                                    ),
                                  if (memberDetails![0]
                                          .memberBasicDetails!
                                          .youtubeLink
                                          .toString() !=
                                      "")
                                    Padding(
                                      padding: EdgeInsets.only(right: 20.w),
                                      child: GestureDetector(
                                        onTap: () {
                                          launchURLMethod(memberDetails![0]
                                              .memberBasicDetails!
                                              .youtubeLink
                                              .toString());
                                        },
                                        child: SocialLinks(
                                            socialLinks: socialLinks[3]),
                                      ),
                                    ),
                                  if (memberDetails![0]
                                          .memberBasicDetails!
                                          .twitterLink
                                          .toString() !=
                                      "")
                                    Padding(
                                      padding: EdgeInsets.only(right: 20.w),
                                      child: GestureDetector(
                                        onTap: () {
                                          launchURLMethod(memberDetails![0]
                                              .memberBasicDetails!
                                              .twitterLink
                                              .toString());
                                        },
                                        child: SocialLinks(
                                            socialLinks: socialLinks[4]),
                                      ),
                                    ),
                                  if (memberDetails![0]
                                          .memberBasicDetails!
                                          .linkedinLink
                                          .toString() !=
                                      "")
                                    Padding(
                                      padding: EdgeInsets.only(right: 0.w),
                                      child: GestureDetector(
                                        onTap: () {
                                          launchURLMethod(memberDetails![0]
                                              .memberBasicDetails!
                                              .linkedinLink
                                              .toString());
                                        },
                                        child: SocialLinks(
                                            socialLinks: socialLinks[5]),
                                      ),
                                    )
                                ]
                                //     List.generate(socialLinks.length, (index) {
                                //   return Padding(
                                //     padding: EdgeInsets.only(
                                //         left: index == 0 ? 0 : 20.w),
                                //     child: SocialLinks(
                                //         socialLinks: socialLinks[index]),
                                //   );
                                // }),
                                ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),

                        // Center(
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       createPayment();
                        //     },
                        //     child: Text(
                        //       "Membership ends in 14 days. Click here to Renew",
                        //       style: GoogleFonts.inter(
                        //           fontSize: 12,
                        //           color: Theme.of(context).primaryColor,
                        //           decoration: TextDecoration.underline),
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 30.h,
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Works",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!),
                            
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        if (memberDetails![0].projectWork!.length != 0)
                          Divider(
                            color: AppTheme.hintTextColor,
                          ),
                        if (memberDetails![0].projectWork!.length != 0)
                          ListView.builder(
                            itemCount: memberDetails![0].projectWork!.length,
                            primary: false,
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(top: 20.h),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${memberDetails![0].projectWork![index].projectName}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(fontSize: 15),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Text(
                                            "${memberDetails![0].projectWork![index].designation}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                       
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          "${memberDetails![0].projectWork![index].year}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  fontSize: 12,
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                          )
                        else
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.h),
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => AddProject(
                                            projectList: ProjectWork(),
                                          )));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/addwork.png",
                                      height: 40.h,
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      "Add Work",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(
                                              fontSize: 14,
                                              color: AppTheme
                                                  .whiteBackgroundColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                )
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 80.h,
                          width: 80.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/images/profile.jpeg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 12.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Guest Name",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!),
                                SizedBox(
                                  height: 6.h,
                                ),
                                Text(
                                  "Guest Designation",
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RichText(
                          textScaleFactor: 1,
                          text: TextSpan(
                            text: ' #',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  fontSize: 18,
                                ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '  2',
                                  style: TextStyle(
                                    fontSize: 14,
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 80.w,
                        ),
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.calendar,
                              size: 22.h,
                            ),
                            Text(' 23-08-2023',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                      fontSize: 14,
                                    )),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Text("Skills",
                        style: Theme.of(context).textTheme.headlineMedium!),
                    SizedBox(
                      height: 6.h,
                    ),
                    Text(
                      "Fluter Java",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Text("Medium",
                        style: Theme.of(context).textTheme.headlineMedium!),
                    SizedBox(
                      height: 6.h,
                    ),
                    Text(
                      "------",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Text("Portfolio Link",
                        style: Theme.of(context).textTheme.headlineMedium!),
                    SizedBox(
                      height: 6.h,
                    ),
                    Text(
                      "www.sica.com",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class SocialLinks extends StatelessWidget {
  SocialLinks({
    super.key,
    this.socialLinks,
  });

  var socialLinks;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40.h,
          width: 40.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: AssetImage("assets/images/${socialLinks["image"]}"),
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Text(
          socialLinks["title"],
          style:
              Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 12),
        )
      ],
    );
  }
}
