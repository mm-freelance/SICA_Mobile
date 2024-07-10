import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/theme.dart';
import 'news_page.dart';

class NewsTabBarWidget extends StatelessWidget {
  const NewsTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        //  backgroundColor: AppTheme.backGround,
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 1,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: (() {
                Navigator.of(context).pop();
              })),
          title: const Text('Latest Updates'),
          bottom: TabBar(
            indicatorWeight: 2,
            indicatorColor: Theme.of(context).primaryColor,
            isScrollable: false,
            tabs: [
              Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: const Text("News"),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: const Text("Blogs"),
              ),
               Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: const Text("Tech Talk"),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[NewsTab(index: 0,),NewsTab(index: 1,),NewsTab(index: 2,)],
        ),
      ),
    );
  }
}
