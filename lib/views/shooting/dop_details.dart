// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:sica/models/DopModel.dart';
// import 'package:sica/theme/theme.dart';
// import 'package:sica/views/shooting/add_associate.dart';

// class DopDetails extends StatefulWidget {
//   const DopDetails({super.key, required this.shootingdetials});
//   final ShootingDopAllDetails shootingdetials;
//   @override
//   State<DopDetails> createState() => _nameState();
// }

// class _nameState extends State<DopDetails> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         titleSpacing: 0,
//         elevation: 1,
//         centerTitle: false,
//         title: const Text("Associates"),
//         actions: [
//           Center(
//             child: GestureDetector(
//               onTap: () {
//                 // Navigator.of(context).push(MaterialPageRoute(
//                 //     builder: (context) => AddAssociate(
//                 //           associate: Associate(),
//                 //           shootingid: widget
//                 //               .shootingdetials.shootingDopDetails!.shootingId
//                 //               .toString(),
//                 //         )));
//               },
//               child: Container(
//                 margin: EdgeInsets.only(right: 10.w),
//                 padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
//                 decoration: BoxDecoration(
//                     color: Theme.of(context).primaryColor,
//                     borderRadius: BorderRadius.circular(5)),
//                 child: Text(
//                   "+ Add",
//                   style: Theme.of(context)
//                       .textTheme
//                       .headlineSmall!
//                       .copyWith(fontSize: 15, color: AppTheme.blackColor),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
//           child: Column(
//             children: [
//               //   Row(
//               //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //     children: [
//               //       Text("Associates",
//               //           style: Theme.of(context).textTheme.headlineMedium!),

//               //     ],
//               //   ),
//               //   SizedBox(
//               //     height: 3.h,
//               //   ),

//               if (widget.shootingdetials.associate!.length != 0)
//                 ListView.builder(
//                   itemCount: widget.shootingdetials.associate!.length,
//                   primary: false,
//                   padding: EdgeInsets.zero,
//                   shrinkWrap: true,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: EdgeInsets.only(top: 20.h),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "${widget.shootingdetials.associate![index].name}",
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .bodySmall!
//                                       .copyWith(fontSize: 15),
//                                 ),
//                                 SizedBox(
//                                   height: 5.h,
//                                 ),
//                                 Text(
//                                   "${widget.shootingdetials.associate![index].mobileNumber}",
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .displaySmall!
//                                       .copyWith(fontSize: 12),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             width: 10.w,
//                           ),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               // GestureDetector(
//                               //   //  behavior: HitTestBehavior.opaque,
//                               //   onTap: () {
//                               //     Navigator.of(context).push(MaterialPageRoute(
//                               //         builder: (context) => AddAssociate(
//                               //               associate: widget.shootingdetials
//                               //                   .associate![index],
//                               //               shootingid: widget.shootingdetials
//                               //                   .shootingDopDetails!.shootingId
//                               //                   .toString(),
//                               //             )));
//                               //   },
//                               //   child: Icon(Icons.edit,
//                               //       size: 17, color: Colors.white),
//                               // ),
//                               // SizedBox(
//                               //   height: 5.h,
//                               // ),
//                               Text(
//                                 "M No. ${widget.shootingdetials.associate![index].memberNumber}",
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .bodySmall!
//                                     .copyWith(
//                                         fontSize: 13,
//                                         color:
//                                             Theme.of(context).iconTheme.color),
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                     );
//                   },
//                 )
//               else
//                 Padding(
//                   padding: EdgeInsets.symmetric(vertical: 20.h),
//                   child: Center(
//                     child: GestureDetector(
//                       onTap: () {
//                         // Navigator.of(context).push(MaterialPageRoute(
//                         //     builder: (context) => AddAssociate(
//                         //           associate: Associate(),
//                         //           shootingid: widget.shootingdetials
//                         //               .shootingDopDetails!.shootingId
//                         //               .toString(),
//                         //         )));
//                       },
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text(
//                             "No Records",
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .headlineSmall!
//                                 .copyWith(
//                                     fontSize: 14,
//                                     color: AppTheme.whiteBackgroundColor),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
