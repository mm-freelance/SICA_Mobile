import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sica/views/gallery/gallery_list.dart';
import '../awards/awards.dart';
import '../forum/select_forum_type.dart';
import '../members/members.dart';

class SeeAllFeatures extends StatelessWidget {
  const SeeAllFeatures({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
        elevation: 0,
        title: const Text("Features"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            // Remove padding
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Discover",
                  style: Theme.of(context).textTheme.headlineMedium!),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SelectForumType()));
                },
                child: _buildIconwithText("Forum", "forum", context),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GalleryList(),
                    ),
                  );
                },
                child: _buildIconwithText("Gallery", "gallery", context),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Awards()));
                },
                child: _buildIconwithText("SICA Awards", "award", context),
              ),
              SizedBox(
                height: 30.h,
              ),
              Text("Shop", style: Theme.of(context).textTheme.headlineMedium!),
              _buildIconwithText("SICA Products", "shop", context),
              SizedBox(
                height: 30.h,
              ),
              Text("User", style: Theme.of(context).textTheme.headlineMedium!),
              _buildIconwithText("Polls", "polls", context),
              _buildIconwithText("Employment", "employement", context),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Members()));
                },
                child: _buildIconwithText("Members", "member", context),
              ),
              _buildIconwithText("Service Provider", "vendors", context),
              SizedBox(
                height: 30.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildIconwithText(String text, String svg, context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/icons/$svg.svg",
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(
            width: 6.w,
          ),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontSize: 15),
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 12.h,
          )
        ],
      ),
    );
  }
}
