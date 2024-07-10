import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sica/theme/theme.dart';

class VendorCardDetails extends StatelessWidget {
  VendorCardDetails({super.key, required this.vendor});
  var vendor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10.h),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(vendor["vendor_name"],
              style: Theme.of(context).textTheme.headlineMedium!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Icon(
                Icons.email_rounded,
                size: 16,
                color: AppTheme.whiteBackgroundColor,
              ),
              SizedBox(
                width: 6,
              ),
              Text(vendor["email"],
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontSize: 14,
                      )),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Icon(
                Icons.phone,
                size: 16,
                color: AppTheme.whiteBackgroundColor,
              ),
              SizedBox(
                width: 6,
              ),
              Text(vendor["phone_number"],
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontSize: 14,
                      )),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Icon(
                CupertinoIcons.globe,
                size: 16,
                color: AppTheme.whiteBackgroundColor,
              ),
               SizedBox(
                width: 6,
              ),
              Text(vendor["website"],
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontSize: 14,
                      )),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                CupertinoIcons.map_pin_ellipse,
                size: 16,
                color: AppTheme.whiteBackgroundColor,
              ),
             SizedBox(
                width: 6,
              ),
              Flexible(
                child: Text(vendor["address"],
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontSize: 14,
                        )),
              ),
            ],
          ),
          // SizedBox(
          //   height: 8,
          // ),
          // Text("Type: ${vendor["vendor_type"]}",
          //     style: Theme.of(context).textTheme.displaySmall!.copyWith(
          //         fontSize: 12, color: Theme.of(context).iconTheme.color)),
        ],
      ),
    );
  }
}
