import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sica/models/DopApprovalModel.dart';
import 'package:sica/models/DopModel.dart';
import 'package:sica/services/member_repo.dart';
import 'package:sica/views/home/dashboard.dart';
import 'package:sica/views/shooting/create_dop.dart';
import 'package:sica/views/shooting/dop_details.dart';
import 'package:sica/views/shooting/shooting_details.dart';

import '../../theme/theme.dart';

class ShootingApprovalList extends StatefulWidget {
  const ShootingApprovalList({super.key});

  @override
  State<ShootingApprovalList> createState() => _nameState();
}

class _nameState extends State<ShootingApprovalList> {
  @override
  void initState() {
    super.initState();
    getApproval();
  }

  List<DopApprovalModel>? dopList;
  void getApproval() {
    final service = MemberRepo();
    service.getApprovalList().then((value) {
      if (value.isNotEmpty) {
        dopList = value;

        if (mounted) setState(() {});
      }
    });
  }

  Future<bool> onWillPop() async {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => MyDashBoard(currentIndex: 0)),
        (_) => false);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
          appBar: AppBar(
            titleSpacing: 12,
            elevation: 0.4,
            leading: GestureDetector(
                onTap: () {
                  onWillPop();
                },
                child: Icon(Icons.arrow_back_ios)),
            title: const Text("DOP Approval"),
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
                    if (dopList!.first.memberShootingPendingDopApproval!.isNotEmpty)
                      Expanded(
                          child: ListView.builder(
                        itemCount: dopList!
                            .first.memberShootingPendingDopApproval!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ShootingDopApproval(
                                          approval: dopList!.first
                                                  .memberShootingPendingDopApproval![
                                              index],
                                        )));
                                //dopList!.first.memberShootingPendingDopApproval![index]
                              },
                              child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.w, vertical: 8.h),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 10.h),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Theme.of(context).cardColor,
                                        border: Border.all(
                                            color: Colors.grey.withOpacity(0.3),
                                            width: 1)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                "${dopList!.first.memberShootingPendingDopApproval![index].projectTitle}",
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
                                                          ' ${dopList!.first.memberShootingPendingDopApproval![index].memberNumber}',
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
                                              "${dopList!.first.memberShootingPendingDopApproval![index].memberName}",
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
                                              "Grade-${dopList!.first.memberShootingPendingDopApproval![index].grade}",
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
                                          "Date- ${dopList!.first.memberShootingPendingDopApproval![index].date}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                        SizedBox(
                                          height: 3.h,
                                        ),
                                        // if (dopList!
                                        //         .first
                                        //         .memberShootingPendingDopApproval![
                                        //             index]
                                        //         .notes !=
                                        //     "")
                                        //   Text(
                                        //     "Notes- ${dopList!.first.memberShootingPendingDopApproval![index].notes}",
                                        //     style: Theme.of(context)
                                        //         .textTheme
                                        //         .bodySmall,
                                        //   ),
                                        // if (dopList!
                                        //         .first
                                        //         .memberShootingPendingDopApproval![
                                        //             index]
                                        //         .notes !=
                                        //     "")
                                        //   SizedBox(
                                        //     height: 6.h,
                                        //   ),
                                      ],
                                    ),
                                  )));
                        },
                      ))
                    else
                      Expanded(
                        child: const Center(
                          child: Text('No  Records'),
                        ),
                      )
                  ],
                )),
    );
  }
}
