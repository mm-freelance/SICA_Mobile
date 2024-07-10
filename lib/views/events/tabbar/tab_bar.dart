import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sica/theme/theme.dart';
import '../events.dart';

class EventsTabBar extends StatelessWidget {
  EventsTabBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        //  backgroundColor: AppTheme.ticketBackground,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(139, 88, 88, 90).withOpacity(0.4),
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
                      padding: EdgeInsets.only(left: 12, top: 10),
                      child:  Icon(Icons.arrow_back, color: AppTheme.whiteBackgroundColor,),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Expanded(child: Container()),
                        TabBar(
                          indicatorWeight: 2,
                          unselectedLabelStyle: AppTheme.text14Px,
                          labelStyle: AppTheme.text14Px,
                          indicatorColor: AppTheme.darkPrimaryColor,
                          isScrollable: false,
                       indicatorSize: TabBarIndicatorSize.label,
                          tabs: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 12.h),
                              child: const Text("All Events"),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 12.h),
                              child: const Text("Booked"),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 12.h),
                              child: const Text("Completed"),
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
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            EventsTab(type: 1),
            EventsTab(
              type: 2,
            ),
            EventsTab(
              type: 3,
            )
          ],
        ),
      ),
    );
  }
}
