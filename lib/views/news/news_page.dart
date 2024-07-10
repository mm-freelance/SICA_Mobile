import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sica/views/news/news_details.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/BlogsModel.dart';
import '../../models/NewsModel.dart';
import '../../models/TechModels.dart';
import '../../services/member_repo.dart';

class NewsTab extends StatefulWidget {
  NewsTab({super.key, required this.index});
  final int index;

  @override
  State<NewsTab> createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> {
  @override
  void initState() {
    super.initState();
    getBlog();
    getNews();
    getTechModels();
  }

  List<BlogsModel>? blogsDataList;
  Future<void> getBlog() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final service = MemberRepo();
    service.getBlogs().then((value) {
      if (value.isNotEmpty) {
        blogsDataList = value;
        if (mounted) setState(() {});
      }
    });
  }

  List<NewsModel>? newsDataList;
  Future<void> getNews() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final service = MemberRepo();
    service.getNews().then((value) {
      if (value.isNotEmpty) {
        newsDataList = value;
        if (mounted) setState(() {});
      }
    });
  }

  String? convertUrlToId(String url, {bool trimWhitespaces = true}) {
    // if (!url.contains("http") && (url.length == 11)) return url;
    print(url);
    // if (trimWhitespaces) url = url.trim();https://youtu.be/84RbcJ58jyY
    RegExp regExp = RegExp(
        r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$");
    RegExp regExp2 =
        RegExp(r"^https:\/\/(?:www\.|m\.)?youtu.be\/([_\-a-zA-Z0-9]{11}).*$");
    // for (var exp in [
    //   RegExp(
    //       r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),

    // ]) {
    Iterable<Match>? matches = regExp.allMatches(url);

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
  List<TechModel>? techDataList;
  Future<void> getTechModels() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final service = MemberRepo();
    service.getTechNews().then((value) {
      if (value.isNotEmpty) {
        techDataList = value;
        if (mounted) setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 16.h,
          ),
          if (newsDataList != null && widget.index == 0)
            ListView.builder(
              itemCount: newsDataList!.first.newsdata!.length,
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetails(
                            news: newsDataList!.first.newsdata![index],
                          ),
                        ),
                      );
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              newsDataList!.first.newsdata![index].date
                                  .toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(fontSize: 12),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Text(
                              newsDataList!.first.newsdata![index].title
                                  .toString(),
                              style: Theme.of(context).textTheme.displayMedium!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              newsDataList!.first.newsdata![index].description
                                  .toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontSize: 12),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                          ],
                        )),
                        SizedBox(
                          width: 10.w,
                        ),
                        Container(
                          height: 70.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.contain,
                                  alignment: Alignment.topCenter,
                                  image: NetworkImage(
                                    newsDataList!.first.newsdata![index].image
                                        .toString(),
                                  )),
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          else if (blogsDataList != null && widget.index == 1)
            ListView.builder(
              itemCount: blogsDataList!.first.sicaBlogsVals!.length,
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetails(
                            news: blogsDataList!.first.sicaBlogsVals![index],
                          ),
                        ),
                      );
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              blogsDataList!.first.sicaBlogsVals![index].date
                                  .toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(fontSize: 12),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Text(
                              blogsDataList!.first.sicaBlogsVals![index].title
                                  .toString(),
                              style: Theme.of(context).textTheme.displayMedium!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              blogsDataList!
                                  .first.sicaBlogsVals![index].description
                                  .toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontSize: 12),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                          ],
                        )),
                        SizedBox(
                          width: 10.w,
                        ),
                        Container(
                          height: 70.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.contain,
                                  alignment: Alignment.topCenter,
                                  image: NetworkImage(
                                    blogsDataList!
                                        .first.sicaBlogsVals![index].image
                                        .toString(),
                                  )),
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          else if (techDataList != null && widget.index == 2)
            ListView.builder(
              itemCount: techDataList!.first.techtalkVals!.length,
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 6.h, horizontal: 14.w),
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => NewsDetails(
                      //       news: techDataList!.first.techtalkVals![index],
                      //     ),
                      //   ),
                      // );
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              techDataList!.first.techtalkVals![index].date
                                  .toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(fontSize: 12),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Text(
                              techDataList!.first.techtalkVals![index].title
                                  .toString(),
                              style: Theme.of(context).textTheme.displayMedium!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            if (techDataList!.first.techtalkVals![index].link
                                    .toString() !=
                                "")
                              Linkify(
                                options: LinkifyOptions(humanize: false),
                                onOpen: (link) async {
                                  if (!await launchUrl(Uri.parse(link.url))) {
                                    throw Exception(
                                        'Could not launch ${link.url}');
                                  }
                                },
                                text: techDataList!
                                    .first.techtalkVals![index].link
                                    .toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(fontSize: 14),
                                linkStyle: TextStyle(color: Colors.blue),
                              ),
                            // Text(
                            //   techDataList!.first.techtalkVals![index].link
                            //       .toString(),
                            //   style: Theme.of(context)
                            //       .textTheme
                            //       .bodySmall!
                            //       .copyWith(
                            //           fontSize: 12, color: Colors.blue),
                            //   maxLines: 2,
                            //   overflow: TextOverflow.ellipsis,
                            // ),
                            SizedBox(
                              height: 8.h,
                            ),
                          ],
                        )),
                        SizedBox(
                          width: 10.w,
                        ),
                        Image.network(
                          getyoutubelink(
                            techDataList!.first.techtalkVals![index].link
                                .toString(),
                          ),
                          fit: BoxFit.cover,
                          height: 70.h,
                          width: 100.w,
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          else
            Center(child: CircularProgressIndicator())
        ],
      ),
    );
  }
}
