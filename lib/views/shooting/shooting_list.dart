import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sica/models/ShootingUpdateModel.dart';
import 'package:sica/views/members/components/members_tabbar.dart';
import 'package:sica/views/shooting/create_shooting.dart';
import 'package:sica/views/shooting/shooting_details.dart';
import '../../components/filter_box.dart';
import '../../components/member_card.dart';
import '../../services/member_repo.dart';
import '../../theme/theme.dart';

class ShootingList extends StatefulWidget {
  const ShootingList({super.key});

  @override
  State<ShootingList> createState() => _nameState();
}

class _nameState extends State<ShootingList> {
  @override
  void initState() {
    super.initState();
    getShootingUpdList();
  }

  List<ShootingUpdateModel>? shotingUpdatesRes;

  void getShootingUpdList() {
    final service = MemberRepo();
    service.getShootingUpdates().then((value) {
      if (value.isNotEmpty) {
        shotingUpdatesRes = value;

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
          centerTitle: false,
          elevation: 0.4,
          title: const Text("Shooting Updates"),
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => CreateShooting(
          //               updatesShot: MemberShooting(),
          //             ),
          //           ),
          //         );
          //       },
          //       icon: Icon(
          //         Icons.add,
          //       ))
          // ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 12.h,
              ),
              if (shotingUpdatesRes != null)
                if (shotingUpdatesRes![0].memberShooting!.isNotEmpty)
                  ListView.builder(
                    itemCount: shotingUpdatesRes![0].memberShooting!.length,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateShooting(
                                updatesShot: shotingUpdatesRes![0]
                                    .memberShooting![index],
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    shotingUpdatesRes![0]
                                        .memberShooting![index]
                                        .projectTitle
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!),
                                SizedBox(
                                  height: 6.h,
                                ),
                                Text(
                                  shotingUpdatesRes![0]
                                      .memberShooting![index]
                                      .memberName
                                      .toString(),
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${shotingUpdatesRes![0].memberShooting![index].medium}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                if (shotingUpdatesRes![0]
                                        .memberShooting![index]
                                        .grade !=
                                    "")
                                  Row(
                                    children: [
                                      Text(
                                        "Grade-${shotingUpdatesRes![0].memberShooting![index].grade}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall,
                                      ),
                                    ],
                                  ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                if (shotingUpdatesRes![0]
                                        .memberShooting![index]
                                        .notes !=
                                    "")
                                  Text(
                                    "Notes- ${shotingUpdatesRes![0].memberShooting![index].notes}",
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
            ],
          ),
        ));
  }
}
