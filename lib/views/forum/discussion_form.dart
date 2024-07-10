import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sica/components/input_feild.dart';
import 'package:sica/models/TopicModel.dart';
import 'package:sica/services/forum_repo.dart';
import 'package:sica/utils/config.dart';
import 'package:sica/views/members/components/members_tabbar.dart';
import '../../components/buton.dart';
import '../../theme/theme.dart';
import '../../utils/images.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'discussion_form_reply.dart';

class DiscussionForm extends StatefulWidget {
  DiscussionForm({super.key, this.category});
  var category;

  @override
  State<DiscussionForm> createState() => _nameState();
}

class _nameState extends State<DiscussionForm> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTopics();
  }

  List<TopicModel>? topicList;
  List<DiscussionForumDetails>? topicListforum;
  void getTopics() {
    final service = Forum();
    service.getTopicList(widget.category["category_id"]).then((value) {
      if (value.isNotEmpty) {
        topicList = value;
        topicListforum = value.first.discussionForumDetails;
        if (mounted) setState(() {});
      }
    });
  }

  SearchList(String query) async {
    if (query.isNotEmpty) {
      topicListforum = topicList!.first.discussionForumDetails!
          .where((elem) => elem.discussionDetails!.topic!
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
      // page = memberBasicDetails!.length;
      //totalNumber = memberBasicDetails!.length;

      setState(() {});
    } else {
      // setState(() {
      //   page = 0;
      //   isLoadedMore = false;
      //   hasNextPage = true;
      // });
      topicListforum = topicList!.first.discussionForumDetails;
      setState(() {});
      // getMemberDetails();
    }
  }

  void submit() {
    if (formKey.currentState!.validate()) {
      final service = Forum();
      DialogHelp.showLoading(context);
      service
          .addTopic(textTopic.text, widget.category["category_id"].toString())
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
                msg: "Topic Added Successfully",
                backgroundColor: Colors.green,
                gravity: ToastGravity.TOP,
                textColor: Colors.white);
            Navigator.of(context).pop();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 0,
          title: Text(widget.category["category_name"]),
          actions: [
            IconButton(
                onPressed: () {
                  showModal(context);
                },
                icon: const Icon(
                  Icons.add,

                  ///  color: AppTheme.bodyTextColor,
                ))
          ],
        ),
        body: topicListforum == null
            ? Center(
                child: CupertinoActivityIndicator(
                  radius: 16,
                  color: Colors.yellow,
                ),
              )
            : Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  if(topicList!.first.discussionForumDetails!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:16),
                    child: TextFormField(
                      //    controller: _serach,
                      onChanged: (value) {
                        SearchList(value);
                      },
                      style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.whiteBackgroundColor),
                      cursorColor: AppTheme.primaryColor,
                      textAlignVertical: TextAlignVertical.center,

                      decoration: InputDecoration(
                        contentPadding: const EdgeInsetsDirectional.fromSTEB(
                            10, 12, 12, 12),
                        isDense: true,
                        fillColor: const Color(0xFF121212),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppTheme.hintTextColor),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppTheme.hintTextColor),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: AppTheme.hintTextColor),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        filled: true,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(
                                color: AppTheme.hintTextColor, fontSize: 14),
                        suffixIcon: InkWell(
                          //  onTap: _serach.clear,
                          child: Icon(Icons.search),
                        ),
                        suffixIconColor:
                            Theme.of(context).textTheme.headlineMedium!.color,
                        hintText: 'Search by Topic',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  if (topicListforum!.isNotEmpty)
                    Expanded(
                        child: ListView.builder(
                      itemCount: topicListforum!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                                    builder: (context) => DiscussionFormReply(
                                          discussionTopicComments:
                                              topicListforum![index],
                                        )))
                                .then((val) => val ? getTopics() : null);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 8.h),
                            child: GestureDetector(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 10.h),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Theme.of(context).cardColor,
                                    border: Border.all(
                                        color: Colors.grey.withOpacity(0.3),
                                        width: 1)),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                                topicListforum![index]
                                                    .discussionDetails!
                                                    .topic
                                                    .toString().toUpperCase(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineMedium!.copyWith(color: AppTheme.primaryColor)),
                                            SizedBox(
                                              height: 4.h,
                                            ),
                                            Text(
                                              "Created by: ${topicListforum![index].discussionDetails!.memberName.toString()} ",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayLarge!
                                                  .copyWith(
                                                      color: AppTheme
                                                          .hintTextColor,fontSize: 14),
                                            ),
                                            if (topicListforum![index]
                                                    .discussionDetails!
                                                    .lastMemberName
                                                    .toString() !=
                                                "false")
                                              SizedBox(
                                                height: 4.h,
                                              ),
                                            if (topicListforum![index]
                                                    .discussionDetails!
                                                    .lastMemberName
                                                    .toString() !=
                                                "false")
                                              Text(
                                                "Last Post by: ${topicListforum![index].discussionDetails!.lastMemberName.toString()} | ${topicListforum![index].discussionDetails!.lastTopicCreateDate.toString()}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(fontSize: 14),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.insert_comment_outlined,
                                          size: 16,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 3),
                                          child: Text(
                                            " ${topicListforum![index].discussionComments!.length.toString()}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall!
                                                .copyWith(
                                                  height: 0,
                                                  fontSize: 14,
                                                ),
                                          ),
                                        )
                                      ],
                                    ),
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
                ],
              ));
  }

  final textTopic = TextEditingController();
  // Default Radio Button Selected Item When App Starts.
  String radioButtonItem = 'All';
  List _topictype = ["All", "Member", "Guest"];
  final formKey = GlobalKey<FormState>();
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
                    color: Theme.of(context).scaffoldBackgroundColor,
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
                                    "Create Topic",
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
                            Flexible(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: 25.0,
                                  maxHeight: 135.0,
                                ),
                                child: Scrollbar(
                                  child: TextFormField(
                                    cursorColor: Colors.blue,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,

                                    style: TextStyle(
                                        color: AppTheme.whiteBackgroundColor),
                                    controller: textTopic,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Enter Topic";
                                      }
                                      return null;
                                    },
                                    maxLength: 50,
                                    //   _handleSubmitted : null,
                                    decoration: InputDecoration(
                                      counterStyle: TextStyle(
                                          fontSize: 12,
                                          color: AppTheme.whiteBackgroundColor),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          borderSide: BorderSide(
                                              color: AppTheme.backGround)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          borderSide: BorderSide(
                                              color: AppTheme.backGround)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          borderSide: BorderSide(
                                              color: AppTheme.backGround)),
                                      contentPadding: EdgeInsets.only(
                                          top: 2.0,
                                          left: 13.0,
                                          right: 13.0,
                                          bottom: 2.0),
                                      hintText: "Type your topic",
                                      hintStyle: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // MyTextField(
                            //     textEditingController: textTopic,
                            //     validation: (value) {
                            //       if (value == null || value.isEmpty) {
                            //         return "Enter Topic";
                            //       }
                            //       return null;
                            //     },
                            //     labelText: "",
                            //     float: FloatingLabelBehavior.always,
                            //     hintText: "Topic Title",
                            //     color: const Color(0xff585A60)),

                            // Text(
                            //   "Who can respond?",
                            //   style: Theme.of(context)
                            //       .textTheme
                            //       .headlineLarge!
                            //       .copyWith(fontSize: 14),
                            // ),
                            // SizedBox(
                            //   height: 8.h,
                            // ),
                            // StatefulBuilder(builder:
                            //     (BuildContext context, StateSetter myState) {
                            //   return Row(
                            //     mainAxisAlignment: MainAxisAlignment.start,
                            //     children: <Widget>[
                            //       for (int i = 0; i < _topictype.length; i++)
                            //         Expanded(
                            //           child: RadioListTile<String>(
                            //               contentPadding: EdgeInsets.zero,
                            //               dense: true,
                            //               visualDensity: const VisualDensity(
                            //                   horizontal:
                            //                       VisualDensity.minimumDensity,
                            //                   vertical:
                            //                       VisualDensity.minimumDensity),
                            //               title: Transform.translate(
                            //                 offset: Offset(-10, 0),
                            //                 child: Text(
                            //                   _topictype[i].toString(),
                            //                   style: Theme.of(context)
                            //                       .textTheme
                            //                       .displayMedium!
                            //                       .copyWith(fontSize: 14),
                            //                 ),
                            //               ),
                            //               value: _topictype[i],
                            //               groupValue: radioButtonItem,
                            //               onChanged: (value) {
                            //                 myState(() {
                            //                   radioButtonItem = value!;
                            //                 });
                            //               }),
                            //         ),
                            //       // Expanded(
                            //       //   child: ListTile(
                            //       //     dense: true,
                            //       //     horizontalTitleGap: 0,
                            //       //     contentPadding: EdgeInsets.zero,
                            //       //     title: Text(
                            //       //       _topictype[i].toString(),
                            //       //       style: Theme.of(context)
                            //       //           .textTheme
                            //       //           .displayMedium!
                            //       //           .copyWith(fontSize: 14),
                            //       //     ),
                            //       //     leading: Radio(
                            //       //       visualDensity: VisualDensity.compact,
                            //       //       value: _topictype[i],
                            //       //       groupValue: radioButtonItem,
                            //       //       onChanged: (value) {
                            //       //         myState(() {
                            //       //           radioButtonItem = value;
                            //       //         });
                            //       //       },
                            //       //     ),
                            //       //   ),
                            //       // ),
                            //     ],
                            //   );
                            // }),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 20.h,
                                bottom: 30.h,
                              ),
                              child: RoundedButton(
                                ontap: () {
                                  submit();
                                },
                                textcolor: Color.fromARGB(255, 0, 0, 0),
                                title: "Create",
                                fontsize: 16,
                                height: 40,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              ));
        });
  }
}
