// import 'package:carousel_slider/carousel_options.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:dots_indicator/dots_indicator.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:sica/views/vendors/vendors_requipements.dart';

// import '../../theme/theme.dart';
// import 'components/operator_cards.dart';

// class OperatorDetails extends StatefulWidget {
//   const OperatorDetails({super.key, required this.vendors});
//   final List vendors;
//   @override
//   State<OperatorDetails> createState() => _nameState();
// }

// class _nameState extends State<OperatorDetails> {
//   int _currentIndex = 0;
//   List bannerImages = [
//     {"images": "assets/images/banner1.png"},
//     {"images": "assets/images/banner2.png"},
//     {"images": "assets/images/banner3.png"},
//     {"images": "assets/images/banner4.png"},
//     {"images": "assets/images/banner5.png"}
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           titleSpacing: 0,
//           elevation: 0,
//           title: Text("Operators"),
//           actions: [
//             IconButton(
//                 onPressed: () {
//                   showModal(context);
//                 },
//                 icon: Icon(
//                   CupertinoIcons.phone,
//                   // color: AppTheme.bodyTextColor,
//                 )),
//           ]),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             CarouselSlider.builder(
//                 itemCount: bannerImages.length,
//                 itemBuilder: (context, index, realIndex) {
//                   return Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 12.w),
//                     child: Stack(
//                       children: [
//                         AspectRatio(
//                           aspectRatio: 16 / 5,
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(16),
//                             child: Image.asset(
//                               bannerImages[index]["images"],
//                               fit: BoxFit.cover,
//                               // color: Color(0x66000000),
//                               // colorBlendMode: BlendMode.darken,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//                 options: CarouselOptions(
//                   //  height: getProportionateScreenHeight(300),
//                   aspectRatio: 16 / 5,
//                   enlargeCenterPage: true,

//                   viewportFraction: 1,
//                   initialPage: 0,
//                   onPageChanged: (index, reason) {
//                     setState(() {
//                       _currentIndex = index;
//                     });
//                   },

//                   enableInfiniteScroll: true,
//                   reverse: false,
//                   autoPlay: true,
//                   autoPlayInterval: Duration(seconds: 3),
//                   autoPlayAnimationDuration: Duration(milliseconds: 800),
//                   // autoPlayCurve: Curves.fastOutSlowIn,
//                   autoPlayCurve: Curves.fastOutSlowIn,
//                   // onPageChanged: pageController,
//                   enlargeStrategy: CenterPageEnlargeStrategy.zoom,

//                   scrollDirection: Axis.horizontal,
//                 )),
//             DotsIndicator(
//               dotsCount: bannerImages.length,
//               position: _currentIndex,
//               decorator: DotsDecorator(
//                 size: const Size.square(9.0),
//                 activeColor: Theme.of(context).primaryColor,
//                 activeSize: const Size(18.0, 9.0),
//                 color: AppTheme.darkPrimaryColor.withOpacity(0.3),
//                 activeShape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(5.0)),
//               ),
//             ),
//             SizedBox(
//               height: 10.h,
//             ),
//             AspectRatio(
//               aspectRatio: 16 / 9,
//               child: Image.asset(
//                 "assets/images/sicaevent1.png",
//                 fit: BoxFit.cover,
//                 colorBlendMode: BlendMode.dstATop,
//               ),
//             ),
//             SizedBox(
//               height: 10.h,
//             ),
//             buildDetailsVendor(),
//           ],
//         ),
//       ),
//     );
//   }

//   buildDetailsVendor() {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 12.w),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Text(' 4.1',
//                   style: Theme.of(context).textTheme.displaySmall!.copyWith(
//                         fontSize: 14,
//                       )),
//               Text(' (1285)',
//                   style: Theme.of(context).textTheme.displaySmall!.copyWith(
//                       fontSize: 12,
//                       color: Theme.of(context).iconTheme.color)),
//             ],
//           ),
//           SizedBox(
//             height: 10.h,
//           ),
//           Text(
//             "Lorem ipsum dolor sit amet. Ut suscipit  of amet explicabeo et voluptatem landandtium amd amet explicabeo et voluptatem Lorem ipsum dolor sit amet. Ut suscipit  of amet explicabeo et amd voluptatem landandtium amd amet explicabeo et voluptatem see more...",
//             style: Theme.of(context).textTheme.bodySmall,
//           ),
//           SizedBox(
//             height: 20.h,
//           ),
//           Text(
//             "Operators",
//             style: Theme.of(context).textTheme.headlineMedium,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           ),
//           // SizedBox(
//           //   height: 10.h,
//           // ),
//           ListView.builder(
//             itemCount: widget.vendors.length,
//             primary: false,
//             shrinkWrap: true,
//             itemBuilder: (context, index) {
//               return GestureDetector(
//                 onTap: () {
//                   Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => VendorsList(
//                           vendorList: widget.vendors[index]["types"])));
//                 },
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(vertical: 12.h),
//                   child: OperatorCardDetails(
//                     operator: widget.vendors[index],
//                   ),
//                 ),
//               );
//             },
//           )
//         ],
//       ),
//     );
//   }

//   void showModal(context) {
//     showModalBottomSheet(
//         context: context,
//         backgroundColor: Colors.transparent,
//         isScrollControlled: true,
//         builder: (context) {
//           return GestureDetector(
//               behavior: HitTestBehavior.opaque,
//               onTap: (() {
//                 //Navigator.of(context).pop();
//               }),
//               child: SingleChildScrollView(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(30.0.r),
//                       topRight: Radius.circular(30.0.r),
//                     ),
//                     color: Theme.of(context).cardColor,
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.only(
//                         right: 16.w,
//                         left: 16.w,
//                         bottom: MediaQuery.of(context).viewInsets.bottom),
//                     child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           SizedBox(
//                             height: 10.h,
//                           ),
//                           Center(
//                             child: Container(
//                               width: 40.w,
//                               height: 4.h,
//                               decoration: BoxDecoration(
//                                   color: Colors.grey[600],
//                                   borderRadius: BorderRadius.circular(12)),
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.symmetric(vertical: 12.h),
//                             child: Text(
//                               "Contact",
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .headlineLarge!
//                                   .copyWith(fontSize: 18),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10.h,
//                           ),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Icon(
//                                 Icons.phone,
//                                 size: 16,
//                               ),
//                               Expanded(
//                                 child: Text("  Call",
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .bodySmall!
//                                         .copyWith(fontSize: 14)),
//                               ),
//                               Text("+91 111871671",
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .bodySmall!
//                                       .copyWith(fontSize: 14)),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 20.h,
//                           ),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Icon(
//                                 Icons.message,
//                                 size: 16,
//                               ),
//                               Expanded(
//                                 child: Text("  Text Message",
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .bodySmall!
//                                         .copyWith(fontSize: 14)),
//                               ),
//                               Text("+91 111871671",
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .bodySmall!
//                                       .copyWith(fontSize: 14)),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 20.h,
//                           ),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Icon(
//                                 CupertinoIcons.app_badge_fill,
//                                 size: 16,
//                               ),
//                               Expanded(
//                                 child: Text("  Whatsapp",
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .bodySmall!
//                                         .copyWith(fontSize: 14)),
//                               ),
//                               Text("+91 111871671",
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .bodySmall!
//                                       .copyWith(fontSize: 14)),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 26.h,
//                           ),
//                         ]),
//                   ),
//                 ),
//               ));
//         });
//   }
// }
