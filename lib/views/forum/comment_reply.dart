import 'dart:convert';
import 'dart:io' as io;
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sica/models/ChildCommentModel.dart';
import 'package:sica/models/TopicModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sica/services/forum_repo.dart';
import 'package:sica/utils/config.dart';
import 'package:sica/views/forum/image_fullview.dart';
import 'package:sica/views/members/components/members_tabbar.dart';
import 'package:sica/views/profile/profile.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/buton.dart';
import '../../components/input_feild.dart';
import '../../theme/theme.dart';

// ignore: must_be_immutable
class ChildCommentPage extends StatefulWidget {
  ChildCommentPage(
      {super.key, required this.comment, required this.discussionid});
  final DiscussionComments comment;
  final String discussionid;
  @override
  State<ChildCommentPage> createState() => _nameState();
}

class _nameState extends State<ChildCommentPage> {
  final commentText = TextEditingController();
  bool istype = false;
  @override
  void initState() {
    super.initState();

    getChildComnt();
  }

  _launchURL(url) async {
    if (Platform.isIOS) {
      if (await canLaunch(url)) {
        await launch(url, forceSafariVC: false);
      } else {
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launh';
        }
      }
    } else {
      url = url;
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  String commentid = "";
  String getYouTubeUrl(String content) {
    RegExp regExp = RegExp(
        r'((?:https?:)?\/\/)?((?:www|m)\.)?((?:youtube\.com|youtu.be))(\/(?:[\w\-]+\?v=|embed\/|v\/)?)([\w\-]+)(\S+)?');
    String? matches = regExp.stringMatch(content);
    if (matches == null) {
      return ''; // Always returns here while the video URL is in the content paramter
    }
    final String youTubeUrl = matches;
    return youTubeUrl;
  }

  File? images;
  String imageurl = "";
  pickFiles() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (image == null) return;

    images = File(
      image.path,
    );
    setState(() {});
  }

  String? convertUrlToId(String url, {bool trimWhitespaces = true}) {
    // if (!url.contains("http") && (url.length == 11)) return url;
    print(url);
    // if (trimWhitespaces) url = url.trim();
    RegExp regExp = RegExp(
        r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$");
    RegExp regExp2 =
        RegExp(r"^https:\/\/(?:www\.|m\.)?youtu.be\/([_\-a-zA-Z0-9]{11}).*$");
    // for (var exp in [
    //   RegExp(
    //       r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),

    // ]) {
    Iterable<Match>? matches = regExp.allMatches(getYouTubeUrl(url));

    //  if (matches.isNotEmpty) {
    for (Match match in matches) {
      return match.group(1);

      //   }
      // && match.first.groupCount >= 1

      //}
    }

    return null;
  }

  getyoutubelink(url) {
    String? videoId = convertUrlToId(url);
    String thumbnailUrl = getThumbnail(videoId: videoId ?? "");
    print(thumbnailUrl);
    return videoId == null ? "" : thumbnailUrl;
  }

  String getThumbnail({
    required String videoId,
    String quality = "sddefault",
    bool webp = true,
  }) =>
      webp
          ? 'https://i3.ytimg.com/vi_webp/$videoId/$quality.webp'
          : 'https://i3.ytimg.com/vi/$videoId/$quality.jpg';
  List<ChildCommentModel>? commentList;
  void getChildComnt() {
    if (commentList != null) {
      commentList!.clear();
    }

    final service = Forum();

    service.getChildComents(widget.comment.commentId!.toString()).then((value) {
      if (value.isNotEmpty) {
        commentList = value;
        if (mounted) setState(() {});
      }
    });
  }

  void submit() {
    // if (formKey.currentState!.validate()) {
    final service = Forum();
    DialogHelp.showLoading(context);
    String img64 = "";
    if (images != "" && images != null) {
      final bytes = io.File(images!.path).readAsBytesSync();

      img64 = base64Encode(bytes);
    }
    service
        .createChildComment(
      commentText.text,
      int.parse(widget.discussionid),
      widget.comment.commentId!.toString(),
    )
        .then((value) {
      DialogHelp().hideLoading(context);
      if (value.isNotEmpty) {
        images = null;
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
          getChildComnt();
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

  void update() {
    // if (formKey.currentState!.validate()) {
    final service = Forum();
    DialogHelp.showLoading(context);
    String img64 = "";
    if (images != "" && images != null) {
      final bytes = io.File(images!.path).readAsBytesSync();

      img64 = base64Encode(bytes);
    }
    service
        .updatechildComent(
      commentText.text,
      int.parse(widget.discussionid),
      commentid.toString(),
    )
        .then((value) {
      DialogHelp().hideLoading(context);
      if (value.isNotEmpty) {
        images = null;
        if (value[0]['error'] != null) {
          Fluttertoast.showToast(
              msg: "Something went wrong",
              backgroundColor: Colors.red,
              gravity: ToastGravity.TOP,
              textColor: Colors.white);
        } else {
          commentText.clear();
          commentid = "";
          Fluttertoast.showToast(
              msg: "Comment updated Successfully",
              backgroundColor: Colors.green,
              gravity: ToastGravity.TOP,
              textColor: Colors.white);
          // Navigator.of(context).pop();
          getChildComnt();
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
          elevation: 0.2,
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context, true);
              },
              child: Icon(Icons.arrow_back_ios)),
          title: const Text("Comment Reply"),
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
        body: commentList == null
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
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 2.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(widget.comment.comment!.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Text(
                                  "Created by: ${widget.comment.memberName.toString()} ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(color: AppTheme.hintTextColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   width: 10.w,
                        // ),
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.end,
                        //   children: [
                        //     Icon(
                        //       Icons.insert_comment_outlined,
                        //       size: 16,
                        //       color: Theme.of(context).primaryColor,
                        //     ),
                        //     Text(
                        //       " ${discussionTopicCommentsList!.discussionComments!.length.toString()}",
                        //       style: Theme.of(context)
                        //           .textTheme
                        //           .headlineSmall!
                        //           .copyWith(
                        //             fontSize: 14,
                        //           ),
                        //     )
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                  Divider(color: AppTheme.backGround2, thickness: 0.2),
                  if (commentList![0].discussionChildCommentDetails!.isNotEmpty)
                    Expanded(
                      child: ListView.builder(
                        // outer ListView
                        /// shrinkWrap: true, // 1st add
                        // primary: false, // 2nd add
                        itemCount: commentList![0]
                            .discussionChildCommentDetails!
                            .length,

                        itemBuilder: (_, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 14.w, vertical: 10.h),
                            child: Slidable(
                              key: const ValueKey(0),
                              enabled: true,
                              // The start action pane is the one at the left or the top side.
                              endActionPane: ActionPane(
                                // A motion is a widget used to control how the pane animates.
                                motion: const ScrollMotion(),

                                // A pane can dismiss the Slidable.

                                extentRatio: 0.5,
                                // All actions are defined in the children parameter.
                                children: [
                                  // A SlidableAction can have an icon and/or a label.
                                  SlidableAction(
                                    onPressed: (context) {
                                      setState(() {
                                        commentText.text = commentList![0]
                                            .discussionChildCommentDetails![
                                                index]
                                            .comment
                                            .toString();
                                        commentid = commentList![0]
                                            .discussionChildCommentDetails![
                                                index]
                                            .childCommentId
                                            .toString();
                                      });
                                    },
                                    backgroundColor: AppTheme.darkTextColor,
                                    foregroundColor:
                                        AppTheme.whiteBackgroundColor,
                                    icon: Icons.edit,
                                    label: 'Edit',
                                  ),
                                ],
                              ),
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
                                    if (commentList![0]
                                            .discussionChildCommentDetails![
                                                index]
                                            .profileImage
                                            .toString() !=
                                        "")
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => MembersTabBar(
                                                  memberid: commentList![0]
                                                      .discussionChildCommentDetails![
                                                          index]
                                                      .membershipNo
                                                      .toString()),
                                            ),
                                          );
                                        },
                                        child: CachedNetworkImage(
                                          height: 36.h,
                                          width: 36.h,
                                          imageUrl: commentList![0]
                                              .discussionChildCommentDetails![
                                                  index]
                                              .profileImage
                                              .toString(),
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                )),
                                          ),
                                          placeholder: (context, url) =>
                                              SizedBox(
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                              color: Colors.yellow,
                                            )),
                                            height: 10.h,
                                            width: 10.h,
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      )
                                    else
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => MembersTabBar(
                                                  memberid: commentList![0]
                                                      .discussionChildCommentDetails![
                                                          index]
                                                      .membershipNo
                                                      .toString()),
                                            ),
                                          );
                                        },
                                        child: Container(
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
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            MembersTabBar(
                                                                memberid: commentList![
                                                                        0]
                                                                    .discussionChildCommentDetails![
                                                                        index]
                                                                    .membershipNo
                                                                    .toString()),
                                                      ),
                                                    );
                                                  },
                                                  child: Text(
                                                      commentList![0]
                                                          .discussionChildCommentDetails![
                                                              index]
                                                          .memberName
                                                          .toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineMedium!
                                                          .copyWith(
                                                              fontSize: 14)),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          if (commentList![0]
                                                  .discussionChildCommentDetails![
                                                      index]
                                                  .comment
                                                  .toString() !=
                                              "")
                                            Linkify(
                                              options: LinkifyOptions(
                                                  humanize: false),
                                              onOpen: (link) async {
                                                if (!await launchUrl(
                                                    Uri.parse(link.url))) {
                                                  throw Exception(
                                                      'Could not launch ${link.url}');
                                                }
                                              },
                                              text: commentList![0]
                                                  .discussionChildCommentDetails![
                                                      index]
                                                  .comment
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineMedium!
                                                  .copyWith(fontSize: 14),
                                              linkStyle:
                                                  TextStyle(color: Colors.blue),
                                            ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          if (getyoutubelink(
                                                commentList![0]
                                                    .discussionChildCommentDetails![
                                                        index]
                                                    .comment
                                                    .toString(),
                                              ) !=
                                              "")
                                            SizedBox(
                                              height: 12.h,
                                            ),
                                          if (getyoutubelink(
                                                commentList![0]
                                                    .discussionChildCommentDetails![
                                                        index]
                                                    .comment
                                                    .toString(),
                                              ) !=
                                              "")
                                            Stack(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                FullScreenImage(
                                                                  url:
                                                                      getyoutubelink(
                                                                    commentList![
                                                                            0]
                                                                        .discussionChildCommentDetails![
                                                                            index]
                                                                        .comment
                                                                        .toString(),
                                                                  ),
                                                                )));
                                                  },
                                                  child: Image.network(
                                                    getyoutubelink(
                                                      commentList![0]
                                                          .discussionChildCommentDetails![
                                                              index]
                                                          .comment
                                                          .toString(),
                                                    ),
                                                    fit: BoxFit.cover,
                                                    height: 200,
                                                    width: 300,
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 14,
                                                  left: 10,
                                                  child: Text(
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                            color:
                                                                Colors.white),
                                                    "Click above link for open youtube",
                                                  ),
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  else
                    Expanded(
                      child: const Center(
                        child: Text('No reply yet'),
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 8, bottom: 12.h, right: 14.w, top: 12.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Expanded(
                        //   child: MyTextField(

                        //       textEditingController: commentText,
                        //       labelText: "",
                        //       float: FloatingLabelBehavior.always,
                        //       hintText: "Add Comment",
                        //       color: const Color(0xff585A60)),
                        // ),
                        // if (images == null && imageurl == "")
                        //   Padding(
                        //     padding: EdgeInsets.only(top: 8, right: 10),
                        //     child: GestureDetector(
                        //       onTap: () {
                        //         pickFiles();
                        //       },
                        //       child: Icon(
                        //         Icons.attach_file,
                        //         size: 30,
                        //       ),
                        //     ),
                        //   )
                        // else if (imageurl != "" && imageurl != "null")
                        //   Container(
                        //     padding: EdgeInsets.only(right: 10),
                        //     height: 45,
                        //     width: 50,
                        //     child: Stack(
                        //       clipBehavior: Clip.none,
                        //       fit: StackFit.expand,
                        //       children: [
                        //         Image.network(
                        //           imageurl,
                        //           fit: BoxFit.cover,
                        //         ),
                        //         Positioned(
                        //             right: -8,
                        //             top: -6,
                        //             child: GestureDetector(
                        //               behavior: HitTestBehavior.opaque,
                        //               onTap: () {
                        //                 setState(() {
                        //                   imageurl = "";
                        //                 });
                        //               },
                        //               child: Container(
                        //                 decoration: BoxDecoration(
                        //                     shape: BoxShape.circle,
                        //                     color: AppTheme.backGround2),
                        //                 child: Icon(
                        //                   Icons.close_sharp,
                        //                   color: Colors.red,
                        //                 ),
                        //               ),
                        //             ))
                        //       ],
                        //     ),
                        //   )
                        // else if (images != null)
                        //   Container(
                        //     padding: EdgeInsets.only(right: 10),
                        //     height: 45,
                        //     width: 50,
                        //     child: Stack(
                        //       clipBehavior: Clip.none,
                        //       fit: StackFit.expand,
                        //       children: [
                        //         Image.file(
                        //           images!,
                        //           fit: BoxFit.cover,
                        //         ),
                        //         Positioned(
                        //             right: -8,
                        //             top: -6,
                        //             child: GestureDetector(
                        //               behavior: HitTestBehavior.opaque,
                        //               onTap: () {
                        //                 setState(() {
                        //                   images = null;
                        //                 });
                        //               },
                        //               child: Container(
                        //                 decoration: BoxDecoration(
                        //                     shape: BoxShape.circle,
                        //                     color: AppTheme.backGround2),
                        //                 child: Icon(
                        //                   Icons.close_sharp,
                        //                   color: Colors.red,
                        //                 ),
                        //               ),
                        //             ))
                        //       ],
                        //     ),
                        //   ),

                        Flexible(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: 25.0,
                              maxHeight: 135.0,
                            ),
                            child: Scrollbar(
                              child: TextField(
                                cursorColor: Colors.blue,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                style: TextStyle(
                                    color: AppTheme.whiteBackgroundColor),
                                controller: commentText,
                                maxLength: 1000,
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
                                  hintText: "Type your reply",
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        InkWell(
                          onTap: () {
                            if (commentText.text.isNotEmpty || images != null) {
                              if (commentid != '') {
                                update();
                              } else {
                                submit();
                              }
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(37, 40, 54, 0.6),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 10.w),
                              child: Text(
                                "Post",
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.primaryColor),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
