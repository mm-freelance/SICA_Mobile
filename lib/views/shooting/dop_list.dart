import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sica/models/DopModel.dart';
import 'package:sica/services/member_repo.dart';
import 'package:sica/views/home/dashboard.dart';
import 'package:sica/views/shooting/create_dop.dart';
import 'package:sica/views/shooting/dop_details.dart';

import '../../theme/theme.dart';

class DOPList extends StatefulWidget {
  const DOPList({super.key});

  @override
  State<DOPList> createState() => _nameState();
}

class _nameState extends State<DOPList> {
  @override
  void initState() {
    super.initState();
    getDopList();
  }

  List<DopModel>? dopList;
  void getDopList() {
    final service = MemberRepo();
    service.getDops().then((value) {
      if (value.isNotEmpty) {
        dopList = value;

        if (mounted) setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 12,
          elevation: 0.4,
          title: const Text("Shooting DOP"),
        ),
        body: dopList == null
            ? const Center(
                child: CupertinoActivityIndicator(
                  radius: 16,
                  color: Colors.yellow,
                ),
              )
            : Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  if (dopList!.first.shootingDOPDetails!.isNotEmpty)
                    Expanded(
                        child: ListView.builder(
                      itemCount: dopList!.first.shootingDOPDetails!.length,
                      itemBuilder: (context, index) {
                        var padding2 = Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "${dopList!.first.shootingDOPDetails![index].shootingDop!.projectTitle}",
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
                                            color:
                                                Theme.of(context).primaryColor),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text:
                                              ' ${dopList!.first.shootingDOPDetails![index].shootingDop!.memberNumber}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppTheme.hintTextColor)),
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
                                  "${dopList!.first.shootingDOPDetails![index].shootingDop!.medium}",
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Grade-${dopList!.first.shootingDOPDetails![index].shootingDop!.grade}",
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            Text(
                              "Date- ${dopList!.first.shootingDOPDetails![index].shootingDop!.date}",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                          ],
                        );
                        return GestureDetector(
                          onTap: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => DopDetails(
                            //           shootingdetials: dopList!.first
                            //               .shootingDopAllDetails![index],
                            //         )));
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 8.h),
                            child: GestureDetector(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 10.h),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Theme.of(context).cardColor,
                                    border: Border.all(
                                        color: Colors.grey.withOpacity(0.3),
                                        width: 1)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: padding2,
                                    ),
                                   
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ))
                  else
                    Expanded(
                      child: const Center(
                        child: Text('No  Records'),
                      ),
                    )
                ],
              ));
  }
}
