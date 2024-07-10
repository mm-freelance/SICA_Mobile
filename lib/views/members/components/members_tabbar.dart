import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sica/theme/theme.dart';
import '../../../models/MemberDetailModel.dart';
import '../../../services/member_repo.dart';
import '../commented_forum.dart';
import '../films_tab.dart';
import '../members_about_tab.dart';

class MembersTabBar extends StatefulWidget {
   final String memberid;
  const MembersTabBar({
    super.key, required this.memberid,
  });

  @override
  State<MembersTabBar> createState() => _MembersTabBarState();
}

class _MembersTabBarState extends State<MembersTabBar> {
List<MemberDetailModel>? memberDetails;

  @override
  void initState() {
    super.initState();
    getMemberDetails();
  }

  String? accountType;

  void getMemberDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  
    if (mounted) setState(() {});
    final service = MemberRepo();
    service.getMemberDetails(widget.memberid).then((value) {
      if (value.isNotEmpty) {
        memberDetails = value;
        if (mounted) setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return memberDetails==null?Center(child: CircularProgressIndicator(),): DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        backgroundColor: AppTheme.blackColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: BoxDecoration(
              //  color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0x8C333335).withOpacity(0.4),
                  offset: Offset(
                    0.0,
                    1.0,
                  ),
                  blurRadius: 2.0,
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Expanded(child: Container()),
                        TabBar(
                          indicatorWeight: 2,
                          indicatorColor: Theme.of(context).primaryColor,
                          isScrollable: false,
                          indicatorSize: TabBarIndicatorSize.label,
                          tabs: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 12.h,left: 10,right: 10),
                              child: const Text("About"),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 12.h,left: 10,right: 10),
                              child: const Text("Forum"),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 12.h,left: 10,right: 10),
                              child: const Text("Work"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body:  TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            MemberAboutTab(memberdetails: memberDetails![0].memberBasicDetails!),
            DiscussionCommented(topicList: memberDetails![0].discussionForum!,),
            FilmsTab(projectWork:memberDetails![0].projectWork!),
          ],
        ),
      ),
    );
  }
}

