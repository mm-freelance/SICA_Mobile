import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sica/views/polls/polls_details.dart';

class Polls extends StatefulWidget {
  const Polls({super.key});

  @override
  State<Polls> createState() => _nameState();
}

class _nameState extends State<Polls> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 0,
        title: const Text("Polls"),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
               Navigator.of(context).push(
                   MaterialPageRoute(builder: (context) => PollsDetails()));
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: Colors.grey.withOpacity(0.3), width: 1)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Best Cinematographer",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!),
                            SizedBox(
                              height: 6.h,
                            ),
                            Text(
                              "Sam | 02 Feb '12",
                              style: Theme.of(context).textTheme.displaySmall,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.insert_comment_outlined,
                          size: 16,
                          color: Theme.of(context).primaryColor,
                        ),
                        Text(
                          " 12.2k",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                fontSize: 14,
                              ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
