import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sica/views/members/components/members_tabbar.dart';

import '../../theme/theme.dart';
import '../../utils/images.dart';
import 'awards_details.dart';

class Awards extends StatefulWidget {
  const Awards({super.key});

  @override
  State<Awards> createState() => _nameState();
}

class _nameState extends State<Awards> {
  String showYear = 'Select Year';
  DateTime _selectedYear = DateTime.now();

  selectYear(context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Year"),
          content: SizedBox(
            width: 300.w,
            height: 300.h,
            child: YearPicker(
              firstDate: DateTime(DateTime.now().year - 50, 1),
              // lastDate: DateTime.now(),
              lastDate: DateTime(DateTime.now().year + 10, 1),
              initialDate: DateTime.now(),
              selectedDate: _selectedYear,
              onChanged: (DateTime dateTime) {
                print(dateTime.year);
                setState(() {
                  _selectedYear = dateTime;
                //  widget._yearController.text = dateTime.year.toString();
                  showYear = "${dateTime.year}";
                  print(showYear);
                  setState(() {});
                });
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //  backgroundColor: AppTheme.backGround2,
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 0,
          title: Text("SICA Awards"),
          actions: [
            IconButton(onPressed: (){
              selectYear(context);
            }, icon: Icon(Icons.calendar_month))
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              child: Row(
                children: [
                  Text("2023 ",
                      style: Theme.of(context).textTheme.displaySmall!),
                  Expanded(
                    child: Divider(
                      color: AppTheme.backGround,
                      thickness: 1.h,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AwardsDetails()));
                  },
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                  )
                                ],
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
