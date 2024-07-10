import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sica/models/EventModel.dart';
import 'package:sica/services/event_repo.dart';
import 'package:sica/theme/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../components/buton.dart';
import '../../components/filter_box.dart';
import 'components/event_card.dart';

class EventsTab extends StatefulWidget {
  const EventsTab({super.key, required this.type});
  final int type;
  @override
  State<EventsTab> createState() => _nameState();
}

class _nameState extends State<EventsTab> {
  List _category = [];
  List _sort = ["Today", "Tomorrow", "This week", "This Month"];
  int _selectIndex = 0;

  // List events = [
  //   {
  //     "title": "Film Camera Training part1",
  //     "date": "March 02 2023",
  //     "duration": "6 Weeks",
  //     "author": "By P.C.Sreeram",
  //     "rupess": "800",
  //     "image": "assets/images/sicaevent1.png"
  //   },
  //   {
  //     "title": "Cinematography",
  //     "date": "March 08 2023",
  //     "duration": "1 Daye",
  //     "author": "By Arul",
  //     "rupess": "1000",
  //     "image": "assets/images/sicaevent2.png"
  //   },
  //   {
  //     "title": "Laser Projection",
  //     "date": "March 15 2023",
  //     "duration": "1 Weeks",
  //     "author": "By M. Ilavarasu",
  //     "rupess": "1800",
  //     "image": "assets/images/sicaevent3.png"
  //   }
  // ];
  List<EventDetails>? events;

  @override
  void initState() {
    super.initState();

    getCategories();
  }

  void getCategories() {
    final service = Eventrepo();
    service.getCategory().then((value) {
      if (value.isNotEmpty) {
        _category = value[0];
        getEventsData();
        if (mounted) setState(() {});
      }
    });
  }

  String? accountType;
  void getEventsData() async {
    final service = Eventrepo();
    service.getEvents(_category[_selectIndex]["category_id"]).then((value) {
      if (value.isNotEmpty) {
        if (widget.type == 1) {
          events = value.first.eventDetails;
        } else if (widget.type == 3) {
          events = value.first.eventDetails!
              .where((element) => element.isCompleted == true)
              .toList();
        } else {
          events = value.first.eventDetails!
              .where((element) => element.is_member_booked == true)
              .toList();
        }
        if (mounted) setState(() {});
      } else {
        events = [];
        if (mounted) setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Row(children: [
            // SizedBox(
            //   width: 12.w,
            // ),
            // GestureDetector(
            //   onTap: () {
            //     showModal(context);
            //   },
            //   child: SvgPicture.asset(
            //     'assets/icons/filter.svg',
            //     color: Theme.of(context).iconTheme.color,
            //     height: 30,
            //   ),
            // ),
            SizedBox(
              width: 12.w,
            ),
            _buildFilterOption()
          ]),
          SizedBox(
            height: 20.h,
          ),
          if (events == null)
            const CircularProgressIndicator()
          else if (events!.isNotEmpty)
            ListView.builder(
              itemCount: events!.length,
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                  child: EventCard(
                    events: events![index],
                    category: _category[_selectIndex]["category_name"],
                  ),
                );
              },
            )
        ],
      ),
    );
  }

  Widget _buildFilterOption() {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
              _category.length,
              (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectIndex = index;
                        events = null;
                        getEventsData();
                      });
                    },
                    child: FilterBox(
                        index: index,
                        selectIndex: _selectIndex,
                        category: _category[index]["category_name"],
                        context: context),
                  )),
        ),
      ),
    );
  }

  RangeValues _values = RangeValues(40.0, 80.0);
  RangeValues values = RangeValues(10, 40);
  void showModal(context) {
    final double min = 0;
    final labels = ['0', '18', '30', '50', '+'];
    final double max = 50;
    RangeValues valuesBottom = RangeValues(0, 2);
    showModalBottomSheet(
        context: context,
        enableDrag: true,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        useSafeArea: true,
        builder: (context) {
          return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (() {
                Navigator.of(context).pop();
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
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Filter",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .copyWith(fontSize: 18),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    "Reset",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(
                                            fontSize: 14,
                                            color: const Color.fromRGBO(
                                                18, 205, 217, 1)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "Sort by:",
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(fontSize: 14),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                  _sort.length,
                                  (index) => GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selectIndex = index;
                                          });
                                        },
                                        child: FilterBox(
                                            index: index,
                                            selectIndex: _selectIndex,
                                            category: _sort[index],
                                            context: context),
                                      )),
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Text(
                            "Type:",
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(fontSize: 14),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                  _category.length,
                                  (index) => GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selectIndex = index;
                                          });
                                        },
                                        child: FilterBox(
                                            index: index,
                                            selectIndex: _selectIndex,
                                            category: _category[index],
                                            context: context),
                                      )),
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Text(
                            "Price:",
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(fontSize: 14),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: Utils.modelBuilder(
                                labels,
                                (index, label) {
                                  final selectedColor = Colors.black;
                                  final unselectedColor =
                                      Colors.black.withOpacity(0.3);
                                  final isSelected =
                                      index >= valuesBottom.start &&
                                          index <= valuesBottom.end;
                                  final color = isSelected
                                      ? selectedColor
                                      : unselectedColor;

                                  return buildLabel(label: label, color: color);
                                },
                              ),
                            ),
                          ),
                          SliderTheme(
                            data: const SliderThemeData(
                              trackHeight: 5,
                              rangeThumbShape: RoundRangeSliderThumbShape(
                                  enabledThumbRadius: 8),
                              overlayShape:
                                  RoundSliderOverlayShape(overlayRadius: 5),
                              activeTickMarkColor: Colors.transparent,
                              inactiveTickMarkColor: Colors.transparent,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RangeSlider(
                                  activeColor: Theme.of(context).primaryColor,
                                  inactiveColor: AppTheme.backGround,
                                  values: values,
                                  min: min,
                                  max: max,
                                  divisions: 50,
                                  labels: RangeLabels(
                                    values.start.round().toString(),
                                    values.end.round().toString(),
                                  ),
                                  onChanged: (values) =>
                                      setState(() => this.values = values),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 30.h, bottom: 20.h, left: 10, right: 10),
                            child: RoundedButton(
                              ontap: () {},
                              textcolor: Color.fromARGB(255, 14, 13, 13),
                              title: "Apply",
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                        ]),
                  ),
                ),
              ));
        });
  }

  Widget buildLabel({
    required String label,
    required Color color,
  }) =>
      Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w400,
        ).copyWith(color: color),
      );
}

class Utils {
  static List<Widget> modelBuilder<M>(
          List<M> models, Widget Function(int index, M model) builder) =>
      models
          .asMap()
          .map<int, Widget>(
              (index, model) => MapEntry(index, builder(index, model)))
          .values
          .toList();
}
