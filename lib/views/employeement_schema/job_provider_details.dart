import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sica/models/JobSeekerProviderMatchModel.dart';

import 'package:sica/services/member_repo.dart';
import 'package:sica/views/employeement_schema/add_provider.dart';
import 'package:sica/views/employeement_schema/job_profile.dart';
import 'package:sica/views/vendors/vendors_details.dart';

import '../../theme/theme.dart';

class JobProvidersMatch extends StatefulWidget {
  const JobProvidersMatch({super.key, required this.jobProviderId});
  final int jobProviderId;
  @override
  State<JobProvidersMatch> createState() => _nameState();
}

class _nameState extends State<JobProvidersMatch> {
  @override
  void initState() {
    super.initState();
    getJobProvidersList();
  }

  List<JobSeekerProviderMatchModel>? jobProviderRes;
  List<JobSeeker>? jobSeeker;
  void getJobProvidersList() {
    final service = MemberRepo();
    service.getMatchSeeker(widget.jobProviderId).then((value) {
      if (value.isNotEmpty) {
        jobProviderRes = value;
        if(jobProviderRes!.first.jobdetails!.isNotEmpty)
        jobSeeker = jobProviderRes!.first.jobdetails!.first.jobseeker;
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
          title: const Text("Job Match"),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            if (jobSeeker != null)
              if (jobSeeker!.isNotEmpty)
                Expanded(
                    child: ListView.builder(
                  itemCount: jobSeeker!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => JobProfile(
                                    memberno: jobSeeker![index].membershipNo.toString(),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                        RichText(
                                          textScaleFactor: 1,
                                          text: TextSpan(
                                            text: 'M No.',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall!
                                                .copyWith(
                                                    fontSize: 14,
                                                    color: AppTheme
                                                        .yelloDarkColor
                                                        .withOpacity(0.8)),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text:
                                                      ' ${jobSeeker![index].membershipNo}',
                                                  style: TextStyle(
                                                    color: AppTheme
                                                        .whiteBackgroundColor,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          "Match -${jobSeeker![index].percentage}%",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium!
                                              .copyWith(
                                                  color: AppTheme.primaryColor,
                                                  fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 6.h,
                                    ),
                                    Text("${jobSeeker![index].memberName}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium!),
                                    if (jobSeeker![index].portifolioLink != "")
                                      SizedBox(
                                        height: 6.h,
                                      ),
                                    if (jobSeeker![index].portifolioLink != "")
                                      Row(
                                        children: [
                                          Text(
                                            "${jobSeeker![index].portifolioLink}",
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
                                          "Grade-${jobSeeker![index].grade}",
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
                                      "Post Apply- ${jobSeeker![index].postApplyingId}",
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
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
