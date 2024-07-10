import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sica/models/PaymentResponse.dart';
import 'package:sica/services/event_repo.dart';
import 'package:sica/views/events/event_book.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/buton.dart';
import '../../models/EventModel.dart';
import '../../services/member_repo.dart';
import '../../theme/theme.dart';
import '../../utils/config.dart';
import '../profile/payment.dart';

class EventDetail extends StatefulWidget {
  EventDetail({
    required this.events,
    super.key,
    required this.category,
  });
  final EventDetails events;
  final String category;

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  int _currentIndex = 0;
  void createPayment(eventid) {
    final service = MemberRepo();
    DialogHelp.showLoading(context);
    service.createEventPayment(eventid).then((value) {
      DialogHelp().hideLoading(context);
      if (value.isNotEmpty) {
        List<PaymentResponse> res = value;
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MakePayment(
                  url: res[0].paymentlink!.shortUrl.toString(),
                  callBackurl: res[0].paymentlink!.callbackUrl.toString(),
                  type: 2,
                  eventid: widget.events.eventId!,
                )));
      } else {
        Fluttertoast.showToast(
            msg: "Something went wrong",
            backgroundColor: Colors.red,
            gravity: ToastGravity.TOP,
            textColor: Colors.white);
      }
    });
  }

  freeEventBook() {
    final service = Eventrepo();
    DialogHelp.showLoading(context);
    service.verifyEvent("Booked", widget.events.eventId!, "Paid").then((value) {
      DialogHelp().hideLoading(context);
      if (value.isNotEmpty) {
        List res = value;
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => EventBook()),
            (_) => false);
      } else {
        Fluttertoast.showToast(
            msg: "Something went wrong",
            backgroundColor: Colors.red,
            gravity: ToastGravity.TOP,
            textColor: Colors.white);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: widget.events.is_member_booked!
            ? RoundedButton(
                height: 40,
                textcolor: Color.fromARGB(255, 255, 254, 254),
                title: "Already Booked",
                ontap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => EventBook(),
                  //   ),
                  // );
                },
                color: Colors.green,
              )
            : RoundedButton(
                height: 40,
                textcolor: Color.fromARGB(255, 0, 0, 0),
                title:
                    widget.events.isCompleted! ? "Already Completed" : "Enroll",
                ontap: () {
                  if (widget.events.isCompleted!) {
                    return;
                  }
                  if (widget.events.amount! > 0) {
                    createPayment(widget.events.eventId.toString());
                  } else {
                    freeEventBook();
                  }
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => EventBook(),
                  //   ),
                  // );
                },
                color: Theme.of(context).primaryColor,
              ),
      ),
      body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Stack(
          children: [
            CarouselSlider.builder(
                itemCount: widget.events.imagesUrl!.length,
                itemBuilder: (context, index, realIndex) {
                  return Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image.network(
                          widget.events.imagesUrl![index],
                          fit: BoxFit.cover,
                          // color: Color(0x66000000),
                          // colorBlendMode: BlendMode.darken,
                        ),
                      ),
                    ],
                  );
                },
                options: CarouselOptions(
                  //  height: getProportionateScreenHeight(300),
                  aspectRatio: 16 / 9,
                  //  enlargeCenterPage: true,

                  viewportFraction: 1,
                  initialPage: 0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },

                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  // autoPlayCurve: Curves.fastOutSlowIn,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  // onPageChanged: pageController,
                  enlargeStrategy: CenterPageEnlargeStrategy.zoom,

                  scrollDirection: Axis.horizontal,
                )),

            // AspectRatio(
            //   aspectRatio: 16 / 9,
            //   child: Image.network(
            //     widget.events.imageUrl.toString(),
            //     fit: BoxFit.cover,
            //     colorBlendMode: BlendMode.dstATop,
            //   ),
            // ),

            Positioned(
              bottom: 10,
              right: 0,
              left: 0,
              child: DotsIndicator(
                dotsCount: widget.events.imagesUrl!.length,
                position: _currentIndex,
                decorator: DotsDecorator(
                  size: const Size.square(9.0),
                  activeColor: Theme.of(context).primaryColor,
                  activeSize: const Size(18.0, 9.0),
                  color: AppTheme.darkTextColor.withOpacity(0.3),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ),
            Positioned(
                top: height + 5,
                left: 10,
                right: 10,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back,
                          color: AppTheme.blackColor),
                    ),
                   
                    //   Icon(Icons.share, color: AppTheme.w),
                  ],
                ))
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 11),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widget.events.title.toString()}",
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: AppTheme.whiteBackgroundColor, fontSize: 16),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 20,
              ),
              if (!widget.events.isCompleted!)
                Column(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/callender.svg",
                          color: AppTheme.whiteBackgroundColor,
                        ),
                        Expanded(
                          child: Text(
                            "  Date: ${widget.events.startDate.toString()}",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(fontSize: 15),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Text(
                              widget.events.amount! > 0
                                  ? " INR ${widget.events.amount.toString()} "
                                  : " Free ",
                              style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    // Row(
                    //   children: [
                    //     SvgPicture.asset(
                    //       "assets/icons/callender.svg",
                    //       color: AppTheme.whiteBackgroundColor,
                    //     ),
                    //     Text(
                    //       "  End date: ${widget.events.endDate.toString()}",
                    //       style: Theme.of(context)
                    //           .textTheme
                    //           .labelSmall!
                    //           .copyWith(fontSize: 15),
                    //     )
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 10.h,
                    // ),
                    Row(
                      children: [
                        Icon(
                          Icons.watch_later_outlined,
                          color: AppTheme.whiteBackgroundColor,
                          size: 16,
                        ),
                        Text(
                          "  Time: ${widget.events.time.toString()}",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(fontSize: 15),
                        )
                      ],
                    ),
                    if (widget.events.venue.toString() != "false")
                      SizedBox(
                        height: 12.h,
                      ),
                    if (widget.events.venue.toString() != "false")
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.pin_drop_outlined,
                            color: AppTheme.whiteBackgroundColor,
                            size: 16,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                //launchUrl(Uri.parse(widget.events.map.toString()));
                              },
                              child: Text(
                                "${widget.events.venue.toString()}",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (widget.events.map.toString() != "false")
                      SizedBox(
                        height: 12.h,
                      ),
                    if (widget.events.map.toString() != "false")
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.map_outlined,
                            color: AppTheme.whiteBackgroundColor,
                            size: 16,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                launchUrl(
                                    Uri.parse(widget.events.map.toString()));
                              },
                              child: Text(
                                " Click to View on map",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(fontSize: 15, color: Colors.blue),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                )
              else
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/callender.svg",
                      color: AppTheme.whiteBackgroundColor,
                    ),
                    Text(
                      "  Date: ${widget.events.startDate.toString()}",
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(fontSize: 15),
                    )
                  ],
                ),
              if (widget.events.programPresenters.toString() != "false")
                SizedBox(
                  height: 12.h,
                ),
              if (widget.events.programPresenters.toString() != "false")
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.person_4,
                      color: AppTheme.whiteBackgroundColor,
                      size: 16,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Program Presenters: ${widget.events.programPresenters.toString()}",
                          style:
                              Theme.of(context).textTheme.labelSmall!.copyWith(
                                    fontSize: 15,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              if (widget.events.presisedBy.toString() != "false")
                SizedBox(
                  height: 12.h,
                ),
              if (widget.events.presisedBy.toString() != "false")
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.person_2_sharp,
                      color: AppTheme.whiteBackgroundColor,
                      size: 16,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Presised By: ${widget.events.presisedBy.toString()}",
                          style:
                              Theme.of(context).textTheme.labelSmall!.copyWith(
                                    fontSize: 15,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              if (widget.events.chiefGuest.toString() != "false")
                SizedBox(
                  height: 12.h,
                ),
              if (widget.events.chiefGuest.toString() != "false")
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.event_seat,
                      color: AppTheme.whiteBackgroundColor,
                      size: 16,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Cheif Guest: ${widget.events.chiefGuest.toString()}",
                          style:
                              Theme.of(context).textTheme.labelSmall!.copyWith(
                                    fontSize: 15,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              if (widget.events.eventLink.toString() != "")
                SizedBox(
                  height: 12.h,
                ),
              if (widget.events.eventLink.toString() != "")
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      CupertinoIcons.globe,
                      color: AppTheme.whiteBackgroundColor,
                      size: 16,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          launchUrl(
                              Uri.parse(widget.events.eventLink.toString()));
                        },
                        child: 
                         RichText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            text: TextSpan(
                              style: Theme.of(context).textTheme.labelSmall!,
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                        'Event link: '),
                                TextSpan(
                                    text: '${widget.events.eventLink.toString()}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,color: Colors.blue
                                    )),
                              ],
                            ),
                          ),
                        // Text(
                        //   "Event link: ${widget.events.eventLink.toString()}",
                        //   style: Theme.of(context)
                        //       .textTheme
                        //       .labelSmall!
                        //       .copyWith(fontSize: 16, color: Colors.blue),
                        // ),
                      ),
                    ),
                  ],
                ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Description",
                style: Theme.of(context).textTheme.headlineMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "${widget.events.description.toString()}",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(
                height: 16.h,
              ),
              Text(
                "About",
                style: Theme.of(context).textTheme.headlineMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "${widget.events.note.toString()}",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 14),
              ),
              SizedBox(
                height: 100.h,
              ),
            ],
          ),
        )
      ])),
    );
  }
}
