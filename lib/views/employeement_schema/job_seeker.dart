import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sica/models/JobSeekeModel.dart';
import 'package:sica/models/OtherMemberProfile.dart';
import 'package:sica/services/member_repo.dart';
import 'package:sica/utils/config.dart';
import 'package:sica/views/employeement_schema/add_seeker.dart';
import 'package:sica/views/home/dashboard.dart';
import '../../components/buton.dart';
import '../../components/dynamic_modal_sheet.dart';
import '../../components/input_feild.dart';
import '../../theme/theme.dart';

class JobSeeker extends StatefulWidget {
  const JobSeeker({super.key});

  @override
  State<JobSeeker> createState() => _nameState();
}

class _nameState extends State<JobSeeker> {
  @override
  void initState() {
    super.initState();
    getJobSeekersList();
  }

  List<JobSeekeModel>? jobPSeekerrRes;

  void getJobSeekersList() {
    final service = MemberRepo();
    service.getJobSeekers().then((value) {
      if (value.isNotEmpty) {
        jobPSeekerrRes = value;

        if (mounted) setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //  backgroundColor: AppTheme.backGround2,
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 1,
          title: const Text("Job Seeker"),
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => AddJobSeeker(
          //               seeker: MemberJobSeeker(),
          //             ),
          //           ),
          //         );
          //       },
          //       icon: Icon(
          //         Icons.add,
          //       ))
          // ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            if (jobPSeekerrRes != null)
              if (jobPSeekerrRes![0].memberJobSeeker!.isNotEmpty)
                Expanded(
                    child: ListView.builder(
                  itemCount: jobPSeekerrRes![0].memberJobSeeker!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                       Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddJobSeeker(
                        seeker:jobPSeekerrRes![0].memberJobSeeker![index],
                      ),
                    ),
                  );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 10.h),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 8.h),
                          decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.3),
                                  width: 1)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            "${jobPSeekerrRes![0].memberJobSeeker![index].postApplyingId}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium!),
                                        RichText(
                                          textScaleFactor: 1,
                                          text: TextSpan(
                                            text: '#',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall!
                                                .copyWith(
                                                    fontSize: 14,
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text:
                                                      ' ${jobPSeekerrRes![0].memberJobSeeker![index].membershipNo}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppTheme
                                                          .hintTextColor)),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 6.h,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "${jobPSeekerrRes![0].memberJobSeeker![index].mediumId}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 6.h,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Grade-${jobPSeekerrRes![0].memberJobSeeker![index].grade}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 6.h,
                                    ),
                                    Text(
                                      "Dates- ${jobPSeekerrRes![0].memberJobSeeker![index].startDate} to ${jobPSeekerrRes![0].memberJobSeeker![index].tillDate}",
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    SizedBox(
                                      height: 6.h,
                                    ),
                                    if (jobPSeekerrRes![0]
                                            .memberJobSeeker![index]
                                            .note !=
                                        "")
                                      Text(
                                        "Notes- ${jobPSeekerrRes![0].memberJobSeeker![index].note}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    if (jobPSeekerrRes![0]
                                            .memberJobSeeker![index]
                                            .note !=
                                        "")
                                      SizedBox(
                                        height: 6.h,
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ))
          ],
        ));
  }
}

class ProviderCard extends StatelessWidget {
  const ProviderCard({
    super.key,
    required this.title,
    required this.index,
  });
  final String title;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(title,
                  style: Theme.of(context).textTheme.headlineMedium!),
            ),
            SizedBox(
              width: 10.w,
            ),
            Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/employement.svg",
                  color: Theme.of(context).primaryColor,
                  height: 20,
                ),
                Text(' $index',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontSize: 14,
                        )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
