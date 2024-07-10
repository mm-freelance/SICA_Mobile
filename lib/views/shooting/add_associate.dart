// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:sica/components/buton.dart';
// import 'package:sica/components/input_feild.dart';
// import 'package:sica/models/DopModel.dart';
// import 'package:sica/models/MemberDetailModel.dart';
// import 'package:sica/services/member_repo.dart';
// import 'package:sica/theme/theme.dart';
// import 'package:sica/utils/config.dart';
// import 'package:sica/views/home/dashboard.dart';
// import 'package:sica/views/shooting/dop_list.dart';

// class AddAssociate extends StatefulWidget {
//   const AddAssociate(
//       {super.key, required this.associate, required this.shootingid});
//   final Associate associate;
//   final String shootingid;

//   @override
//   State<AddAssociate> createState() => _nameState();
// }

// class _nameState extends State<AddAssociate> {
//   String showYear = 'Select Year';
//   DateTime _selectedYear = DateTime.now();
//   final name = TextEditingController();
//   final memberno = TextEditingController();
//   final mobile = TextEditingController();
//   List issueTypes = [
//     {"ans": "Associate"},
//     {"ans": "Assistant"},
//     {"ans": "Operative"}
//   ];
//   @override
//   void initState() {
//     super.initState();
//     if (widget.associate.name != null) {
//       name.text = widget.associate.name.toString();
//       memberno.text = widget.associate.memberNumber.toString();

//       mobile.text = widget.associate.mobileNumber.toString();
//     }
//     setState(() {});
//   }

//   void submit() {
//     if (formKey.currentState!.validate()) {
//       final service = MemberRepo();
//       DialogHelp.showLoading(context);
//       service
//           .addAssociate(
//               widget.shootingid, name.text, memberno.text, mobile.text)
//           .then((value) {
//         DialogHelp().hideLoading(context);
//         if (value.isNotEmpty) {
//           Fluttertoast.showToast(
//               msg: "Associate Added Successfully",
//               backgroundColor: Colors.green,
//               gravity: ToastGravity.TOP,
//               textColor: Colors.white);
//           Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(builder: (BuildContext context) => DOPList()),
//               (_) => false);
//         } else {
//           Fluttertoast.showToast(
//               msg: "Something went wrong",
//               backgroundColor: Colors.red,
//               gravity: ToastGravity.TOP,
//               textColor: Colors.white);
//         }
//       });
//     }
//   }

//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   // void editWork() {
//   //   if (formKey.currentState!.validate()) {
//   //     final service = MemberRepo();
//   //     DialogHelp.showLoading(context);
//   //     service
//   //         .editWork(name.text, year.text, designation.text,
//   //             int.parse(widget.associate.memberId.toString()))
//   //         .then((value) {
//   //       DialogHelp().hideLoading(context);
//   //       if (value.isNotEmpty) {
//   //         Fluttertoast.showToast(
//   //             msg: "Work Edit Successfully",
//   //             backgroundColor: Colors.green,
//   //             gravity: ToastGravity.TOP,
//   //             textColor: Colors.white);
//   //         Navigator.pushAndRemoveUntil(
//   //             context,
//   //             MaterialPageRoute(
//   //                 builder: (BuildContext context) =>
//   //                     MyDashBoard(currentIndex: 3)),
//   //             (_) => false);
//   //       } else {
//   //         Fluttertoast.showToast(
//   //             msg: "Something went wrong",
//   //             backgroundColor: Colors.red,
//   //             gravity: ToastGravity.TOP,
//   //             textColor: Colors.white);
//   //       }
//   //     });
//   //   }
//   // }  final formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         titleSpacing: 0,
//         elevation: 1,
//         title: Text(widget.associate.memberId != null
//             ? "Edit Associate"
//             : "Add Associate"),
//         // actions: [
//         //   if( widget.projectList.id != null)
//         //   Padding(
//         //     padding: const EdgeInsets.only(right: 6),
//         //     child: IconButton(
//         //       icon: Icon(Icons.delete, color: Colors.red,),
//         //       onPressed: () {deleteWork();},
//         //     ),
//         //   )
//         // ],
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
//         child: Form(
//           key: formKey,
//           child: Column(
//             children: [
//               SizedBox(height: 8.h),
//               MyTextField(
//                   textEditingController: name,
//                   validation: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "Enter Name";
//                     }
//                     return null;
//                   },
//                   hintText: "Name",
//                   float: FloatingLabelBehavior.always,
//                   labelText: "",
//                   color: const Color(0xff585A60)),
//               SizedBox(height: 8.h),
//               MyTextField(
//                   textEditingController: memberno,
//                   validation: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "Member No. is required";
//                     }
//                     return null;
//                   },
//                   hintText: "Enter Member No.",
//                   float: FloatingLabelBehavior.always,
//                   labelText: "",
//                   color: const Color(0xff585A60)),
//               SizedBox(height: 8.h),
//               MyTextField(
//                   textEditingController: mobile,
//                   float: FloatingLabelBehavior.always,
//                   validation: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "Mobile is required";
//                     }
//                     return null;
//                   },
//                   hintText: "Enter Mobile",
//                   labelText: "",
//                   color: const Color(0xff585A60)),
//               Padding(
//                 padding: EdgeInsets.symmetric(vertical: 30.h),
//                 child: RoundedButton(
//                     ontap: () {
//                       // if (widget.projectList.id != null) {
//                       //   editWork();
//                       // } else {
//                       submit();
//                       // }
//                     },
//                     title: "Save",
//                     color: Theme.of(context).primaryColor,
//                     textcolor: AppTheme.darkTextColor),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
