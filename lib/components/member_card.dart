import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sica/theme/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MemberCard extends StatelessWidget {
  final String name;
  final String designation;
  final String date;
  final String memberno;
  final String image;
  const MemberCard({
    super.key,
    required this.name,
    required this.designation,
    required this.date,
    required this.memberno,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (image != "")
              // Container(
              //   height: 50.h,
              //   width: 50.h,
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     image: DecorationImage(
              //       image: NetworkImage`(image),
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              // )
              CachedNetworkImage(
                height: 50.h,
                width: 50.h,
                imageUrl: image,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      )),
                ),
                
                // placeholder: (context, url) => SizedBox(
                //   child: Center(
                //       child: const CircularProgressIndicator(
                //     color: Colors.yellow,
                //   )),
                //   height: 10.h,
                //   width: 10.h,
                // ),
                errorWidget: (context, url, error) =>Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("assets/images/profile.jpeg"),
                        fit: BoxFit.cover,
                      )),
                ),
              )
            else
              Container(
                height: 50.h,
                width: 50.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage("assets/images/profile.jpeg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(name,
                        style: Theme.of(context).textTheme.headlineMedium!),
                    SizedBox(
                      height: 6.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "$designation",
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        // if (designation != "")
                        //   Text(
                        //     " | ",
                        //     style: Theme.of(context).textTheme.displaySmall,
                        //   ),
                        if (designation == "")
                          Text(
                            "$date",
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            RichText(
              textScaleFactor: 1,
              text: TextSpan(
                text: 'M.no:',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontSize: 14, color: Theme.of(context).primaryColor),
                children: <TextSpan>[
                  TextSpan(
                      text: '$memberno',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.hintTextColor)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
