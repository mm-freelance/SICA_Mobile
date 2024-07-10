import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../components/gallery_card.dart';
import '../../services/gallery_repo.dart';
import '../../services/member_repo.dart';
import '../../theme/theme.dart';
import 'gallery.dart';

class GalleryList extends StatefulWidget {
  const GalleryList({super.key});

  @override
  State<GalleryList> createState() => _nameState();
}

class _nameState extends State<GalleryList> {
  // List galleryList = [
  //   {"title": "Movies", "image": "assets/images/website.png"},
  //   {"title": "Camera", "image": "assets/images/workshop.png"}
  // ];
  @override
  void initState() {
    super.initState();
    getJobSeekersList();
  }

  List galleryListCategory = [];

  void getJobSeekersList() {
    final service = GalleryRepo();
    service.getGalleryCategory().then((value) {
      if (value.isNotEmpty) {
        galleryListCategory = value[0];

        if (mounted) setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 0,
          title: const Text("Gallery"),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.w),
            child: galleryListCategory.isNotEmpty
                ? GridView.builder(
                    itemCount: galleryListCategory.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 20.w,
                        mainAxisSpacing: 20.h,
                        crossAxisCount: 2,
                        mainAxisExtent: 90.h),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => GalleryScreen(
                                    category: galleryListCategory[index]
                                        ["category_name"],
                                    categoryid: galleryListCategory[index]
                                            ["category_id"]
                                        .toString(),
                                  )));
                        },
                        child: GalleryWidget(
                            galleryList: galleryListCategory[index]),
                      );
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  )));
  }
}
