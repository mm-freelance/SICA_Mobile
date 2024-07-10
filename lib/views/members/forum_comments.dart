import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sica/models/TopicModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sica/services/forum_repo.dart';
import 'package:sica/utils/config.dart';
import '../../components/buton.dart';
import '../../components/input_feild.dart';
import '../../models/MemberDetailModel.dart';
import '../../theme/theme.dart';

// ignore: must_be_immutable
class ForumComments extends StatefulWidget {
  ForumComments({super.key, required this.discussionTopicComments});
  final DiscussionForum discussionTopicComments;
  @override
  State<ForumComments> createState() => _nameState();
}

class _nameState extends State<ForumComments> {
  final commentText = TextEditingController();
  bool istype = false;
  @override
  void initState() {
    super.initState();
    getTopics();
  }

  List<TopicModel>? topicList;
  DiscussionForumDetails? discussionTopicCommentsList;
  void getTopics() {
    final service = Forum();
    textTopic.text = widget.discussionTopicComments.topic!.topic.toString();
    service
        .getTopicList(
            widget.discussionTopicComments.topic!.categoryId)
        .then((value) {
      if (value.isNotEmpty) {
        topicList = value;
        List<DiscussionForumDetails> aa = value.first.discussionForumDetails!
            .where((element) =>
                element.discussionDetails!.discussionId.toString() ==
               widget.discussionTopicComments.topic!.discussionId
                    .toString())
            .toList();
        discussionTopicCommentsList = aa[0];
        if (mounted) setState(() {});
      }
    });
  }

  void submit() {
    // if (formKey.currentState!.validate()) {
    final service = Forum();
    DialogHelp.showLoading(context);
    service
        .createCommment(commentText.text,
           widget.discussionTopicComments.topic!.discussionId!,"")
        .then((value) {
      DialogHelp().hideLoading(context);
      if (value.isNotEmpty) {
        if (value[0]['error'] != null) {
          Fluttertoast.showToast(
              msg: "Something went wrong",
              backgroundColor: Colors.red,
              gravity: ToastGravity.TOP,
              textColor: Colors.white);
        } else {
          commentText.clear();
          Fluttertoast.showToast(
              msg: "Comment Added Successfully",
              backgroundColor: Colors.green,
              gravity: ToastGravity.TOP,
              textColor: Colors.white);
          // Navigator.of(context).pop();
          getTopics();
        }

        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(
        //         builder: (BuildContext context) =>
        //             MyDashBoard(currentIndex: 3)),
        //     (_) => false);
      } else {
        Fluttertoast.showToast(
            msg: "Something went wrong",
            backgroundColor: Colors.red,
            gravity: ToastGravity.TOP,
            textColor: Colors.white);
      }
    });
  }

  void deleteTopic() {
    // if (formKey.currentState!.validate()) {
    final service = Forum();
    DialogHelp.showLoading(context);
    service
        .deleteTopic(
            textTopic.text,
            widget.discussionTopicComments.topic!.discussionId
                .toString())
        .then((value) {
      DialogHelp().hideLoading(context);
      if (value.isNotEmpty) {
        if (value[0]['error'] != null) {
          Fluttertoast.showToast(
              msg: "Something went wrong",
              backgroundColor: Colors.red,
              gravity: ToastGravity.TOP,
              textColor: Colors.white);
        } else {
          commentText.clear();
          Fluttertoast.showToast(
              msg: "Delete Successfully",
              backgroundColor: Colors.green,
              gravity: ToastGravity.TOP,
              textColor: Colors.white);
          Navigator.pop(context, true);
          Navigator.pop(context, true);
        }
      } else {
        Fluttertoast.showToast(
            msg: "Something went wrong",
            backgroundColor: Colors.red,
            gravity: ToastGravity.TOP,
            textColor: Colors.white);
      }
    });
  }

  final formKey = GlobalKey<FormState>();
  void updateTopic() {
    if (formKey.currentState!.validate()) {
      final service = Forum();
      DialogHelp.showLoading(context);
      service
          .editTopic(
              textTopic.text,
              widget.discussionTopicComments.topic!.discussionId
                  .toString())
          .then((value) {
        DialogHelp().hideLoading(context);
        if (value.isNotEmpty) {
          if (value[0]['error'] != null) {
            Fluttertoast.showToast(
                msg: "Something went wrong",
                backgroundColor: Colors.red,
                gravity: ToastGravity.TOP,
                textColor: Colors.white);
          } else {
            textTopic.clear();
            Fluttertoast.showToast(
                msg: "Topic Updated Successfully",
                backgroundColor: Colors.green,
                gravity: ToastGravity.TOP,
                textColor: Colors.white);
            Navigator.pop(context, true);
            Navigator.pop(context, true);
          }

          // Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(
          //         builder: (BuildContext context) =>
          //             MyDashBoard(currentIndex: 3)),
          //     (_) => false);
        } else {
          Fluttertoast.showToast(
              msg: "Something went wrong",
              backgroundColor: Colors.red,
              gravity: ToastGravity.TOP,
              textColor: Colors.white);
        }
      });
    }
  }

  showDialogSubmit() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Column(
                    children: [
                      Text(
                        "Are you sure you want to delete this topic",
                        style: GoogleFonts.roboto(
                            decoration: TextDecoration.none,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.whiteBackgroundColor),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 26.h),
                      //Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 110.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppTheme.backGround2),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 12.h,
                                ),
                                child: Center(
                                  child: Text(
                                    "CANCEL",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .copyWith(
                                          fontSize: 14,
                                          color: AppTheme.blackColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              deleteTopic();
                            },
                            child: Container(
                              width: 110.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.red),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                                child: Center(
                                  child: Text(
                                    "DELETE",
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.none,
                                        fontSize: 14,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<bool> onWillPop() async {
    Navigator.pop(context, true);

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 1,
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context, true);
              },
              child: Icon(Icons.arrow_back_ios)),
          title: const Text("Comments"),
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         showModal(context);
          //       },
          //       icon: const Icon(
          //         Icons.edit,
          //         // color: AppTheme.bodyTextColor,
          //       )),
          //   IconButton(
          //       onPressed: () {
          //         showDialogSubmit();
          //       },
          //       icon: const Icon(
          //         Icons.delete,
          //         // color: AppTheme.bodyTextColor,
          //       ))
          // ],
        ),
        body: discussionTopicCommentsList == null
            ? Center(
                child: CupertinoActivityIndicator(
                  radius: 16,
                  color: Colors.yellow,
                ),
              )
            : Column(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // if (widget.discussionTopicComments.discussionDetails!
                        //         .last_commit_member_image !=
                        //     "")
                        //   CachedNetworkImage(
                        //     height: 36.h,
                        //     width: 36.h,
                        //     imageUrl: widget.discussionTopicComments
                        //         .discussionDetails!.last_commit_member_image
                        //         .toString(),
                        //     imageBuilder: (context, imageProvider) => Container(
                        //       decoration: BoxDecoration(
                        //           shape: BoxShape.circle,
                        //           image: DecorationImage(
                        //             image: imageProvider,
                        //             fit: BoxFit.cover,
                        //           )),
                        //     ),
                        //     placeholder: (context, url) => SizedBox(
                        //       child: Center(
                        //           child: const CircularProgressIndicator(
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
                        //   height: 36.h,
                        //     width: 36.h,
                        //     decoration: const BoxDecoration(
                        //       shape: BoxShape.circle,
                        //       image: DecorationImage(
                        //         image: AssetImage("assets/images/profile.jpeg"),
                        //         fit: BoxFit.cover,
                        //       ),
                        //     ),
                        //   ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 2.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    widget.discussionTopicComments.topic!.topic
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!),
                                // SizedBox(
                                //   height: 6.h,
                                // ),
                                //  if(topicList!.first.discussionForumDetails![index].discussionDetails!.last_member_name.toString()!="false")
                                //             SizedBox(
                                //               height: 6.h,
                                //             ),
                                //             if(topicList!.first.discussionForumDetails![index].discussionDetails!.last_member_name.toString()!="false")
                                //             Text(
                                //               "${topicList!.first.discussionForumDetails![index].discussionDetails!.last_member_name.toString()} | ${topicList!.first.discussionForumDetails![index].discussionDetails!.last_topic_create_date.toString()}",
                                //               style: Theme.of(context)
                                //                   .textTheme
                                //                   .bodySmall!
                                //                   .copyWith(fontSize: 14),
                                //             ),
                                // Text(
                                //   "${widget.discussionTopicComments.discussionDetails!.last_member_name.toString()} | ${widget.discussionTopicComments.discussionDetails!.last_topic_create_date.toString()}",
                                //   style: Theme.of(context).textTheme.displaySmall,
                                // ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Text(
                                  "Created by: ${widget.discussionTopicComments.topic!.memberName.toString()} ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(color: AppTheme.hintTextColor),
                                ),
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
                              " ${discussionTopicCommentsList!.discussionComments!.length.toString()}",
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
                  Divider(color: AppTheme.backGround2, thickness: 0.2),
                  if (discussionTopicCommentsList!
                      .discussionComments!.isNotEmpty)
                    Expanded(
                      child: ListView.builder(
                        // outer ListView
                        /// shrinkWrap: true, // 1st add
                        // primary: false, // 2nd add
                        itemCount: discussionTopicCommentsList!
                            .discussionComments!.length,
                        itemBuilder: (_, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 14.w, vertical: 10.h),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 10.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Theme.of(context).cardColor,
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.3),
                                      width: 1)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (discussionTopicCommentsList!
                                          .discussionComments![index]
                                          .profileImage
                                          .toString() !=
                                      "")
                                    CachedNetworkImage(
                                      height: 36.h,
                                      width: 36.h,
                                      imageUrl: discussionTopicCommentsList!
                                          .discussionComments![index]
                                          .profileImage
                                          .toString(),
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                      placeholder: (context, url) => SizedBox(
                                        child: Center(
                                            child:
                                                const CircularProgressIndicator(
                                          color: Colors.yellow,
                                        )),
                                        height: 10.h,
                                        width: 10.h,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    )
                                  else
                                    Container(
                                      height: 50.h,
                                      width: 50.h,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/profile.jpeg"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                  discussionTopicCommentsList!
                                                      .discussionComments![
                                                          index]
                                                      .memberName
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineMedium!),
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Text(
                                              "2 mints ago ",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!,
                                          discussionTopicCommentsList!
                                              .discussionComments![index]
                                              .comment
                                              .toString(),
                                        ),
                                        SizedBox(
                                          height: 4.h,
                                        ),
                                        // SizedBox(
                                        //   height: 16.h,
                                        // ),
                                        // ListView.builder(
                                        //   // inner ListView
                                        //   shrinkWrap: true, // 1st add
                                        //   physics: ClampingScrollPhysics(), // 2nd add
                                        //   itemCount: 2,
                                        //   itemBuilder: (_, index) => Padding(
                                        //     padding: EdgeInsets.only(
                                        //         left: 30.w, bottom: 10.h, top: 10.h),
                                        //     child: Container(
                                        //       padding: EdgeInsets.symmetric(
                                        //           horizontal: 10.w, vertical: 8.h),
                                        //       decoration: BoxDecoration(
                                        //           borderRadius: BorderRadius.circular(8),
                                        //           color: Theme.of(context).cardColor,
                                        //           border: Border.all(
                                        //               color: Colors.grey.withOpacity(0.3),
                                        //               width: 1)),
                                        //       child: Column(
                                        //         children: [
                                        //           Row(
                                        //             crossAxisAlignment:
                                        //                 CrossAxisAlignment.center,
                                        //             children: [
                                        //               Container(
                                        //                 height: 30.h,
                                        //                 width: 30.h,
                                        //                 decoration: BoxDecoration(
                                        //                   shape: BoxShape.circle,
                                        //                   image: DecorationImage(
                                        //                     image: AssetImage(
                                        //                         'assets/images/tie.jpg'),
                                        //                     fit: BoxFit.cover,
                                        //                   ),
                                        //                 ),
                                        //               ),
                                        //               Expanded(
                                        //                 child: Padding(
                                        //                   padding: EdgeInsets.only(left: 8.w),
                                        //                   child: Text("Vimal",
                                        //                       style: Theme.of(context)
                                        //                           .textTheme
                                        //                           .headlineMedium!),
                                        //                 ),
                                        //               ),
                                        //               SizedBox(
                                        //                 width: 10.w,
                                        //               ),
                                        //               Text(
                                        //                 "2 mints ago",
                                        //                 style: TextStyle(fontSize: 12),
                                        //               )
                                        //             ],
                                        //           ),
                                        //           SizedBox(
                                        //             height: 8.h,
                                        //           ),
                                        //           Text(
                                        //             style:
                                        //                 Theme.of(context).textTheme.bodySmall!,
                                        //             "Here i’m studying B. Sc. Statistics this is my final year. I liked this college because i learned to my life. The staffs from my department ",
                                        //           )
                                        //         ],
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  else
                    Expanded(
                      child: const Center(
                        child: Text('No Comments yet'),
                      ),
                    ),
                  // Padding(
                  //   padding: EdgeInsets.only(
                  //       left: 14.w, bottom: 12.h, right: 14.w, top: 12.h),
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       Expanded(
                  //         child: MyTextField(
                  //             textEditingController: commentText,
                  //             labelText: "",
                  //             float: FloatingLabelBehavior.always,
                  //             hintText: "Add Comment",
                  //             color: const Color(0xff585A60)),
                  //       ),
                  //       SizedBox(
                  //         width: 10.w,
                  //       ),
                  //       InkWell(
                  //         onTap: () {
                  //           if (commentText.text.isNotEmpty) {
                  //             submit();
                  //           }
                  //         },
                  //         child: Container(
                  //           margin: EdgeInsets.only(bottom: 5),
                  //           decoration: BoxDecoration(
                  //             color: const Color.fromRGBO(37, 40, 54, 0.6),
                  //             borderRadius: BorderRadius.circular(6),
                  //           ),
                  //           child: Padding(
                  //             padding: EdgeInsets.symmetric(
                  //                 vertical: 10.h, horizontal: 10.w),
                  //             child: Text(
                  //               "Post",
                  //               style: GoogleFonts.inter(
                  //                   fontSize: 14,
                  //                   fontWeight: FontWeight.w600,
                  //                   color: AppTheme.primaryColor),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // )
                ],
              ),
      ),
    );
  }

  // Default Radio Button Selected Item When App Starts.
  String radioButtonItem = 'All';
  List _topictype = ["All", "Member", "Guest"];
  final textTopic = TextEditingController();
  void showModal(context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) {
          return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (() {
                //Navigator.of(context).pop();
              }),
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0.r),
                      topRight: Radius.circular(30.0.r),
                    ),
                    color: Theme.of(context).cardColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: 16.w,
                        left: 16.w,
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Form(
                      key: formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Edit Topic",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(fontSize: 18),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Icon(Icons.cancel,
                                          color:
                                              Color.fromRGBO(18, 205, 217, 1))),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            MyTextField(
                                textEditingController: textTopic,
                                validation: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Enter Topic";
                                  }
                                  return null;
                                },
                                labelText: "",
                                float: FloatingLabelBehavior.always,
                                hintText: "Topic Title",
                                color: const Color(0xff585A60)),
                            SizedBox(
                              height: 10.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 16.h, bottom: 20.h, left: 10, right: 10),
                              child: RoundedButton(
                                ontap: () {
                                  updateTopic();
                                },
                                textcolor: Color.fromARGB(255, 14, 13, 13),
                                title: "Update",
                                height: 40,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                          ]),
                    ),
                  ),
                ),
              ));
        });
  }
}
