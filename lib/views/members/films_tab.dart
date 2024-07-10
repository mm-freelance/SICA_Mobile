import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sica/models/MemberDetailModel.dart';
import 'package:sica/theme/theme.dart';
import 'package:sica/views/profile/add_project.dart';
import '../../components/movie_card.dart';

class FilmsTab extends StatefulWidget {
  const FilmsTab({super.key, required this.projectWork});
 final List<ProjectWork> projectWork;

  @override
  State<FilmsTab> createState() => _nameState();
}

class _nameState extends State<FilmsTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if ( widget.projectWork.isNotEmpty)
          Expanded(
            child: ListView.builder(
              itemCount:widget.projectWork.length,
             
              padding: EdgeInsets.zero,
             
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(top: 20.h, left: 12,right: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${widget.projectWork[index].projectName}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontSize: 15),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              "${widget.projectWork[index].designation}",
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                         
                          Text(
                            "${widget.projectWork[index].year}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          )
        else
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Text(
                  "No Work",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(
                          fontSize: 14,
                          color: AppTheme.whiteBackgroundColor),
                ),
              ],
            ),
          )
      ],
    );
  }
}
