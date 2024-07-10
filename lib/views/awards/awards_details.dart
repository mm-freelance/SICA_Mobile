import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sica/views/members/components/members_tabbar.dart';

import '../../theme/theme.dart';
import '../../utils/images.dart';

class AwardsDetails extends StatefulWidget {
  const AwardsDetails({super.key});

  @override
  State<AwardsDetails> createState() => _nameState();
}

class _nameState extends State<AwardsDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //  backgroundColor: AppTheme.backGround2,
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 0,
          title: Text("Best Cinematographer"),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Expanded(
                child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: Colors.grey.withOpacity(0.3), width: 1)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 50.h,
                            width: 50.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage('assets/images/tie.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 8.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Ravi K Chandran",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  Text(
                                    "Samurai",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: Text(
                                "Tamil",
                                style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: AppTheme.bodyTextColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ))
          ],
        ));
  }
}
