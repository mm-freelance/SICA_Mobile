import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sica/models/JobProviderModel.dart';
import 'package:sica/models/OtherMemberProfile.dart';
import 'package:sica/services/member_repo.dart';
import 'package:sica/views/employeement_schema/add_provider.dart';
import 'package:sica/views/vendors/vendors_details.dart';

import '../../models/JobProvider2Model.dart';
import '../../models/JobSeekeModel.dart';
import '../../theme/theme.dart';
import 'job_provider_details.dart';

class JobProviders extends StatefulWidget {
  const JobProviders({super.key});

  @override
  State<JobProviders> createState() => _nameState();
}

class _nameState extends State<JobProviders> {
  @override
  void initState() {
    super.initState();
    getJobProvidersList();
  }

  List<JobProvider2Model>? jobProviderRes;

  void getJobProvidersList() {
    final service = MemberRepo();
    service.getJobProviders().then((value) {
      if (value.isNotEmpty) {
        jobProviderRes = value;

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
          elevation: 0,
          title: const Text("Job Provider"),
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => AddProvider(),
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
            if (jobProviderRes != null)
              if (jobProviderRes![0].memberJobSeeker != null)
                Expanded(
                    child: ListView.builder(
                  itemCount: jobProviderRes![0].memberJobSeeker!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => JobProvidersMatch(
                                  jobProviderId: jobProviderRes![0]
                                      .memberJobSeeker![index]
                                      .jobProviderId!,
                                )));
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
                                            "${jobProviderRes![0].memberJobSeeker![index].postRequiredId}",
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
                                                      ' ${jobProviderRes![0].memberJobSeeker![index].membershipNo}',
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
                                          "${jobProviderRes![0].memberJobSeeker![index].mediumId}",
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
                                          "Grade-${jobProviderRes![0].memberJobSeeker![index].grade}",
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
                                      "Dates- ${jobProviderRes![0].memberJobSeeker![index].requiredFrom} to ${jobProviderRes![0].memberJobSeeker![index].requiredTill}",
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    SizedBox(
                                      height: 6.h,
                                    ),
                                    if (jobProviderRes![0]
                                            .memberJobSeeker![index]
                                            .note !=
                                        "")
                                      Text(
                                        "Notes- ${jobProviderRes![0].memberJobSeeker![index].note}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    if (jobProviderRes![0]
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
