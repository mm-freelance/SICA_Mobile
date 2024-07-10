
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OperatorCardDetails extends StatelessWidget {
  OperatorCardDetails({super.key, required this.operator});
  var operator;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 50.h,
            width: 50.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/camera.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: Text(
                  operator["name"],
                  style: Theme.of(context).textTheme.headlineMedium!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.star,
                    size: 18.h,
                    color: Theme.of(context).primaryColor,
                  ),
                  Text(' 4.1',
                      style:
                          Theme.of(context).textTheme.displaySmall!.copyWith(
                                fontSize: 14,
                              )),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(' (3.5k)',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontSize: 12,
                      color: Theme.of(context).iconTheme.color)),
            ],
          ),
        ],
      ),
    );
  }
}

