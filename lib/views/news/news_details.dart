import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/NewsModel.dart';

class NewsDetails extends StatelessWidget {
  NewsDetails({
    required this.news,
    super.key,
  });
  var news;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("News"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (news.image != null)
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                          image: NetworkImage(news.image)),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      )),
                ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                news.title,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontSize: 16),
              ),
              SizedBox(
                height: 6,
              ),
              if (news.description != null)
                Text(
                  news.description.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontSize: 14, height: 1.4),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
