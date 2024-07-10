import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sica/theme/theme.dart';

class PollsDetails extends StatefulWidget {
  const PollsDetails({super.key});

  @override
  State<PollsDetails> createState() => _nameState();
}

class _nameState extends State<PollsDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 1,
        title: const Text("Polls"),
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
                  onTap: () {
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (context) => AwardsDetails()));
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: Colors.grey.withOpacity(0.3), width: 1)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                  ],
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
                          SizedBox(
                            height: 16.h,
                          ),
                          ...List.generate(
                              4,
                              (index) => Padding(
                                    padding: EdgeInsets.only(bottom: 20.h),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text("Member 1",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineSmall!
                                                          .copyWith(
                                                              fontSize: 14)),
                                                  Text("8k",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .displaySmall!
                                                          .copyWith(
                                                              fontSize: 12,
                                                              color: AppTheme
                                                                  .hintTextColor)),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child:
                                                    const LinearProgressIndicator(
                                                  backgroundColor: Colors.grey,
                                                  valueColor:
                                                      AlwaysStoppedAnimation(
                                                          Colors.blueAccent),
                                                  minHeight: 5,
                                                  value: 30 / 100,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 12.w,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.white)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(2),
                                            child: Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              size: 14,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                          Text("Details",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(fontSize: 14)),
                          SizedBox(
                            height: 6.h,
                          ),
                          Text(
                            "Lorem ipsum dolor sit amet. Ut suscipit   sum dolor sit amet. Ut suscipit  of amet explicabeo et amd voluptatem landandtium amd amet explicabeo et voluptatem see more...",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
