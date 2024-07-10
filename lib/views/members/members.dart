import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sica/models/OtherMemberProfile.dart';
import 'package:sica/services/member_repo.dart';
import 'package:sica/views/members/components/members_tabbar.dart';

import '../../components/member_card.dart';
import '../../theme/theme.dart';
import '../../utils/images.dart';

class Members extends StatefulWidget {
  const Members({super.key});

  @override
  State<Members> createState() => _nameState();
}

class _nameState extends State<Members> {
  // List<OtherMemberProfile>? memberDetails;
  List<MemberBasicDetails>? memberBasicDetails;
  late ScrollController scrollController;
  bool isLoadedMore = false;
  bool hasNextPage = true;
  @override
  void initState() {
    super.initState();
    getMemberDetails();
    getMemberAllData();
    scrollController = ScrollController()..addListener(loadMore);
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  void loadMore() {
    List<OtherMemberProfile>? memberDetails2;
    if (hasNextPage == true &&
        isLoadedMore == false &&
        scrollController.position.maxScrollExtent == scrollController.offset) {
      isLoadedMore = true;
      page = page + 100;
      final service = MemberRepo();
      print(page);
      service.getAllMemberDetails(page.toString()).then((value) {
        if (value.isNotEmpty) {
          memberDetails2 = value;
          if (memberDetails2!.first.memberBasicDetails!.isNotEmpty) {
            memberBasicDetails =
                memberBasicDetails! + memberDetails2!.first.memberBasicDetails!;
          } else {
            hasNextPage = false;
          }
          isLoadedMore = false;
          if (mounted) setState(() {});
        }
      });
    }
  }

  // void loadnumbers() {
  //   if (hasNextPage == true &&
  //       isLoadedMore == false &&
  //       scrollController.position.maxScrollExtent == scrollController.offset) {
  //     isLoadedMore = true;

  //     if (totalNumber > page) {
  //       page = page + 100;
  //       //final service = MemberRepo();
  //       print(page);
  //       if (page > totalNumber) {
  //         page = totalNumber;
  //       }
  //     } else {
  //       hasNextPage = false;
  //     }
  //     isLoadedMore = false;
  //     if (mounted) setState(() {});
  //   }
  // }

  int page = 0;
  // int totalNumber = 0;
  void getMemberDetails() {
    final service = MemberRepo();
    service.getAllMemberDetails(page.toString()).then((value) {
      if (value.isNotEmpty) {
        //  memberDetails = value;
        //  totalNumber = value.first.memberBasicDetails!.length;
        memberBasicDetails = value.first.memberBasicDetails;
        // memberBasicDetails = value.first.memberBasicDetails.sort((a, b) {
        //   return a.memberDetails!.membershipNo!.compareTo(b.memberDetails!.membershipNo!);
        // });
        // memberBasicDetails!.sort((a, b) =>
        //     int.parse(a.memberDetails!.membershipNo.toString()).compareTo(
        //         int.parse(b.memberDetails!.membershipNo.toString())));
        if (mounted) setState(() {});
      }
    });
  }

  // void getMemberAllData() {
  //   final service = MemberRepo();
  //   service.getAllMemberData().then((value) {
  //     if (value.isNotEmpty) {
  //       memberDetails = value;
  //       print("loaded");
  //       //  totalNumber = value.first.memberBasicDetails!.length;
  //       // memberBasicDetails = value.first.memberBasicDetails;
  //       // memberBasicDetails = value.first.memberBasicDetails.sort((a, b) {
  //       //   return a.memberDetails!.membershipNo!.compareTo(b.memberDetails!.membershipNo!);
  //       // });
  //       // memberBasicDetails!.sort((a, b) =>
  //       //     int.parse(a.memberDetails!.membershipNo.toString()).compareTo(
  //       //         int.parse(b.memberDetails!.membershipNo.toString())));
  //       if (mounted) setState(() {});
  //     }
  //   });
  // }
  List<MemberBasicDetails>? memberBasicDetails2;
  Future<void> getMemberAllData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final rawJson = sharedPreferences.getString('memberList') ?? '';
    var jsonMap = json.decode(rawJson);
    memberBasicDetails = List<MemberBasicDetails>.from(
        jsonMap.map((x) => MemberBasicDetails.fromJson(x)));
    memberBasicDetails2 = memberBasicDetails;
    
    print("loaded");
  }

  SearchList(String query) async {
    if (query.isNotEmpty) {
      memberBasicDetails = memberBasicDetails2!
          .where((elem) =>
              elem.memberDetails!.name!
                  .toLowerCase()
                  .startsWith(query.toLowerCase()) ||
              elem.memberDetails!.membershipNo!
                  .toLowerCase()
                  .startsWith(query.toLowerCase()))
          .toList();
      // page = memberBasicDetails!.length;
      //totalNumber = memberBasicDetails!.length;

      isLoadedMore = true;
      setState(() {});
    } else {
      setState(() {
        page = 0;
        isLoadedMore = false;
        hasNextPage = true;
      });
      getMemberDetails();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //  backgroundColor: AppTheme.backGround2,
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 0,
          title: Text("All Members"),
          actions: [
            IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.search,
                  color: AppTheme.bodyTextColor,
                ))
          ],
        ),
        body: SingleChildScrollView(
          physics:
              AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          controller: scrollController,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  //    controller: _serach,
                  onChanged: (value) {
                    SearchList(value);
                  },
                  style: TextStyle(
                      fontSize: 14, color: AppTheme.whiteBackgroundColor),
                  cursorColor: AppTheme.primaryColor,
                  textAlignVertical: TextAlignVertical.center,

                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsetsDirectional.fromSTEB(10, 12, 12, 12),
                    isDense: true,
                    fillColor: const Color(0xFF121212),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppTheme.hintTextColor),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppTheme.hintTextColor),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppTheme.hintTextColor),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    filled: true,
                    hintStyle: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(
                            color: AppTheme.hintTextColor, fontSize: 14),
                    suffixIcon: InkWell(
                      //  onTap: _serach.clear,
                      child: Icon(Icons.search),
                    ),
                    suffixIconColor:
                        Theme.of(context).textTheme.headlineMedium!.color,
                    hintText: 'Search by Name or M no.',
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              if (memberBasicDetails != null)
                if (memberBasicDetails!.isNotEmpty)
                  ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: memberBasicDetails!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MembersTabBar(
                                    memberid: memberBasicDetails![index]
                                        .memberDetails!
                                        .membershipNo!,
                                  )));
                        },
                        child: MemberCard(
                          name: memberBasicDetails![index]
                              .memberDetails!
                              .name
                              .toString(),
                          designation: memberBasicDetails![index]
                              .memberDetails!
                              .grade
                              .toString(),
                          date: memberBasicDetails![index]
                              .memberDetails!
                              .joiningDate
                              .toString(),
                          memberno: memberBasicDetails![index]
                              .memberDetails!
                              .membershipNo
                              .toString(),
                          image: memberBasicDetails![index]
                              .memberDetails!
                              .image
                              .toString(),
                        ),
                      );
                    },
                  ),
              if (hasNextPage == false)
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: const Center(
                    child: Text('no more Records'),
                  ),
                )
              else if (!isLoadedMore)
                Container(
                    alignment: Alignment.center,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: const CupertinoActivityIndicator(
                        radius: 12,
                        color: Colors.yellow,
                      ),
                    ))
              //   else
              //     Center(
              //       child: Text("No Records"),
              //     )
              // else
              //   Center(
              //     child: CircularProgressIndicator(),
              //   ),
            ],
          ),
        ));
  }
}
