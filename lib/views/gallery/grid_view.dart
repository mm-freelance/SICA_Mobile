import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_share/flutter_share.dart';

import '../../models/GalleryModel.dart';
import 'detail_screen.dart';
import 'grid_data.dart';

class GalleryGridView extends StatelessWidget {
  const GalleryGridView({Key? key, this.galleryList}) : super(key: key);
final  List<GalleryModel>? galleryList;
  @override
  Widget build(BuildContext context) {
   
    return MasonryGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 20,
      crossAxisSpacing: 14,
      
      itemCount: galleryList!.first.galleryDetails!.length,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailScreen(
                          data: galleryList!.first.galleryDetails![index],
                       
                        )));
          },
          child: tile( galleryList!.first.galleryDetails![index], context),
        );
      },
    );
  }

  tile(gridList, context) {
    return Container(
     
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              gridList.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: 12.h, bottom: 12.h, left: 6.w, right: 6.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(gridList.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                // GestureDetector(
                //     onTap: () {
                //       _share(this, gridList[index].name, gridList[index].image);
                //     },
                //     child: Icon(
                //       Icons.more_vert,
                //       size: 20,
                //     ))
              ],
            ),
          )
        ],
      ),
    );
  }

  void _share(context, name, image) async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
  }
}
