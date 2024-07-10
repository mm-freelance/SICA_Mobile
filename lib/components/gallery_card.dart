import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/theme.dart';

class GalleryWidget extends StatelessWidget {
  GalleryWidget({
    super.key,
    required this.galleryList,
  });
  var galleryList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      width: 140.w,
      // alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.primaryColor.withOpacity(0.4)),
          // image: DecorationImage(
          //     fit: BoxFit.cover,
          //     colorFilter:const ColorFilter.mode(
          //       Color.fromARGB(102, 92, 82, 82),
          //       BlendMode.darken,
          //     ),
          //     image: AssetImage(galleryList["image"])),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            galleryList["category_name"],
            style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppTheme.whiteBackgroundColor),
          ),
         
        ],
      ),
    );
  }
}
