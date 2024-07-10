import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sica/views/members/forum_comments.dart';

import '../../models/MemberDetailModel.dart';
import '../../theme/theme.dart';
import '../forum/discussion_form_reply.dart';

class DiscussionCommented extends StatelessWidget {
  const DiscussionCommented({super.key, required this.topicList});
  final List<DiscussionForum> topicList;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 20.h,
      ),
      SizedBox(
        height: 10.h,
      ),
      if (topicList.isNotEmpty)
        Expanded(
            child: ListView.builder(
          itemCount: topicList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ForumComments(
                          discussionTopicComments:
                              topicList[index]!
                        )));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                child: GestureDetector(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Theme.of(context).cardColor,
                        border: Border.all(
                            color: Colors.grey.withOpacity(0.3), width: 1)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // if (topicList!
                        //         .first
                        //         .discussionForumDetails![index]
                        //         .discussionDetails!
                        //         .last_commit_member_image !=
                        //     "")
                        //   CachedNetworkImage(
                        //     height: 36.h,
                        //     width: 36.h,
                        //     imageUrl: topicList!
                        //         .first
                        //         .discussionForumDetails![index]
                        //         .discussionDetails!
                        //         .last_commit_member_image
                        //         .toString(),
                        //     imageBuilder:
                        //         (context, imageProvider) =>
                        //             Container(
                        //       decoration: BoxDecoration(
                        //           shape: BoxShape.circle,
                        //           image: DecorationImage(
                        //             image: imageProvider,
                        //             fit: BoxFit.cover,
                        //           )),
                        //     ),
                        //     placeholder: (context, url) => SizedBox(
                        //       child: Center(
                        //           child:
                        //               const CircularProgressIndicator(
                        //         color: Colors.yellow,
                        //       )),
                        //       height: 10.h,
                        //       width: 10.h,
                        //     ),
                        //     errorWidget: (context, url, error) =>
                        //         Icon(Icons.error),
                        //   )
                        // else
                        //   Container(
                        //     height: 50.h,
                        //     width: 50.h,
                        //     decoration: const BoxDecoration(
                        //       shape: BoxShape.circle,
                        //       image: DecorationImage(
                        //         image: AssetImage(
                        //             "assets/images/profile.jpeg"),
                        //         fit: BoxFit.cover,
                        //       ),
                        //     ),
                        //   ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 2.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(topicList[index].topic!.topic.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Text(
                                  "Created by: ${topicList[index].topic!.memberName.toString()} ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(color: AppTheme.hintTextColor),
                                ),
                                // if (topicList[index]
                                //         .topic!
                                //         .last_member_name
                                //         .toString() !=
                                //     "false")
                                //   SizedBox(
                                //     height: 4.h,
                                //   ),
                                // if (topicList!
                                //         .first
                                //         .discussionForumDetails![index]
                                //         .discussionDetails!
                                //         .last_member_name
                                //         .toString() !=
                                //     "false")
                                //   Text(
                                //     "Last Post by: ${topicList!.first.discussionForumDetails![index].discussionDetails!.last_member_name.toString()} | ${topicList!.first.discussionForumDetails![index].discussionDetails!.last_topic_create_date.toString()}",
                                //     style: Theme.of(context)
                                //         .textTheme
                                //         .bodySmall!
                                //         .copyWith(fontSize: 14),
                                //   ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   children: [
                        //     Icon(
                        //       Icons.insert_comment_outlined,
                        //       size: 16,
                        //       color: Theme.of(context).primaryColor,
                        //     ),
                        //     Padding(
                        //       padding: const EdgeInsets.only(bottom: 3),
                        //       child: Text(
                        //         " ${topicList!.first.discussionForumDetails![index].discussionComments!.length.toString()}",
                        //         style: Theme.of(context)
                        //             .textTheme
                        //             .headlineSmall!
                        //             .copyWith(
                        //               height: 0,
                        //               fontSize: 14,
                        //             ),
                        //       ),
                        //     )
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ))
      else
        Expanded(
          child: const Center(
            child: Text('No  Records'),
          ),
        )
    ]);
  }
}
