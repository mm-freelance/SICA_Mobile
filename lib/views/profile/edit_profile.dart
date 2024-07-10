import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:sica/models/MemberDetailModel.dart';
import 'package:sica/services/member_repo.dart';
import 'package:sica/utils/config.dart';
import 'package:sica/views/home/dashboard.dart';
import 'package:sica/views/profile/add_project.dart';
import 'package:sica/views/profile/add_work.dart';
import 'package:image_picker/image_picker.dart';
import '../../components/buton.dart';
import '../../components/input_feild.dart';
import '../../components/movie_card.dart';
import '../../theme/theme.dart';
import '../login/otp_page.dart';

class EditProfile extends StatefulWidget {
  EditProfile({super.key, required this.details});
  final MemberBasicDetails details;
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final mobile = TextEditingController();
  bool contactInfo = false;  bool notesShow = false;
  final name = TextEditingController();

  final memberno = TextEditingController();

  final designation = TextEditingController();

  final skills = TextEditingController();

  final medium = TextEditingController();

  final experience = TextEditingController();

  final portfiliolink = TextEditingController();

  final notes = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mobile.text = widget.details.mobileNumber.toString();
    name.text = widget.details.name.toString();
    memberno.text = widget.details.membershipNo.toString();
    designation.text = widget.details.designation.toString();
    skills.text = widget.details.skills.toString();
    medium.text = widget.details.medium.toString();
    portfiliolink.text = widget.details.portifolioLink.toString();
    notes.text = widget.details.notes.toString();
    contactInfo =
        widget.details.contact_show.toString() == "false" ? false : true;
         notesShow =
        widget.details.notes_show.toString() == "false" ? false : true;
    experience.text = widget.details.experience.toString();
  }

  void submit() {
    if (_formKey.currentState!.validate()) {
      final service = MemberRepo();
      DialogHelp.showLoading(context);
      service
          .updateMembers(
              widget.details.mobileNumber.toString(),
              widget.details.name.toString(),
              widget.details.membershipNo.toString(),
              widget.details.designation.toString(),
              widget.details.skills.toString(),
              widget.details.medium.toString(),
              widget.details.experience.toString(),
              portfiliolink.text,
              notes.text.toString(),
              contactInfo ? "True" : "False", notesShow ? "True" : "False")
          .then((value) {
        DialogHelp().hideLoading(context);
        if (value.isNotEmpty) {
          Fluttertoast.showToast(
              msg: "Updated Successfully",
              backgroundColor: Colors.green,
              gravity: ToastGravity.CENTER,
              textColor: Colors.white);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      MyDashBoard(currentIndex: 3)),
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
  }

  Future getImageCamera(ImageSource img) async {
    try {
      final image = await ImagePicker().pickImage(
        source: img,
      );
      if (image == null) return;

      final imageTemp = File(
        image.path,
      );

      final croppedFile = await ImageCropper().cropImage(
        cropStyle: CropStyle.circle,
        sourcePath: image.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              backgroundColor: AppTheme.darkTextColor,
              activeControlsWidgetColor: AppTheme.primaryColor,
              toolbarColor: AppTheme.darkTextColor,
              toolbarWidgetColor: AppTheme.whiteBackgroundColor,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );
      if (croppedFile != null) {
        // uploadImage(File(croppedFile.path), 1);
      }

      //if (!mounted) return;
    } on PlatformException catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   backgroundColor: AppTheme.whiteBackgroundColor,
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 1,
        centerTitle: false,
        title: Text("Profile"),
        actions: [
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddProject(
                          projectList: ProjectWork(),
                        )));
              },
              child: Container(
                margin: EdgeInsets.only(right: 10),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  "+ Work",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontSize: 16, color: AppTheme.whiteBackgroundColor),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      if (widget.details.image.toString() == "")
                        Container(
                          height: 100.h,
                          width: 100.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/images/profile.jpeg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      else
                        Container(
                          height: 100.h,
                          width: 100.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image:
                                  NetworkImage(widget.details.image.toString()),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      //   GestureDetector(
                      //     //  behavior: HitTestBehavior.opaque,
                      //     onTap: () {
                      //       print("object");
                      //       showModalChangeProfilePic(context);
                      //     },
                      //     child: Container(
                      //       height: 30.h,
                      //       width: 30.h,
                      //       alignment: Alignment.center,
                      //       decoration: BoxDecoration(
                      //           border: Border.all(
                      //             width: 3,
                      //             color: Colors.white,
                      //           ),
                      //           borderRadius: const BorderRadius.all(
                      //             Radius.circular(
                      //               50,
                      //             ),
                      //           ),
                      //           color: Colors.white,
                      //           boxShadow: [
                      //             BoxShadow(
                      //               offset: Offset(0, 0),
                      //               color: Colors.black.withOpacity(
                      //                 0.5,
                      //               ),
                      //               blurRadius: 1,
                      //             ),
                      //           ]),
                      //       child: Icon(Icons.edit,
                      //           size: 14, color: Colors.black),
                      //     ),
                      //   )
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Show Member Number",
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(fontSize: 13),
                    ),
                    Transform.scale(
                      scale: .7,
                      child: CupertinoSwitch(
                        value: contactInfo,
                        onChanged: (value) {
                          contactInfo = value;
                          setState(
                            () {},
                          );
                        },
                        trackColor: CupertinoColors.systemGrey,
                        thumbColor: CupertinoColors.systemGrey5,
                        activeColor: Colors.blue,
                      ),
                    ),
                  ],
                ),

                MyTextField(
                    readOnly: true,
                    textEditingController: mobile,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Mobile Number";
                      }
                      return null;
                    },
                    hintText: "Mobile number",
                    color: const Color(0xff585A60)),
                SizedBox(height: 8.h),
                Text(
                  "Name",
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(fontSize: 13),
                ),
                SizedBox(height: 2.h),
                MyTextField(
                    readOnly: true,
                    textEditingController: name,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Name";
                      }
                      return null;
                    },
                    hintText: "Name",
                    color: const Color(0xff585A60)),
                SizedBox(height: 8.h),
                Text(
                  "Membership No.",
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(fontSize: 13),
                ),
                SizedBox(height: 2.h),
                MyTextField(
                    readOnly: true,
                    textEditingController: memberno,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Membership No.";
                      }
                      return null;
                    },
                    hintText: "Membership No.",
                    color: const Color(0xff585A60)),

                // Text(
                //   "Designation/Grade",
                //   style: Theme.of(context)
                //       .textTheme
                //       .labelSmall!
                //       .copyWith(fontSize: 13),
                // ),
                // SizedBox(height: 2.h),
                // MyTextField(
                //     textEditingController: designation,
                //     validation: (value) {
                //       if (value == null || value.isEmpty) {
                //         return "Enter Designation/Grade";
                //       }
                //       return null;
                //     },
                //     hintText: "Designation/Grade",
                //     color: const Color(0xff585A60)),
                // SizedBox(height: 8.h),
                // Text(
                //   "Skills",
                //   style: Theme.of(context)
                //       .textTheme
                //       .labelSmall!
                //       .copyWith(fontSize: 13),
                // ),
                // SizedBox(height: 2.h),
                // MyTextField(
                //     textEditingController: skills,
                //     validation: (value) {
                //       if (value == null || value.isEmpty) {
                //         return "Enter Skills";
                //       }
                //       return null;
                //     },
                //     hintText: "Skills",
                //     color: const Color(0xff585A60)),
                // SizedBox(height: 8.h),
                // Text(
                //   "Medium",
                //   style: Theme.of(context)
                //       .textTheme
                //       .labelSmall!
                //       .copyWith(fontSize: 13),
                // ),
                // SizedBox(height: 2.h),
                // MyTextField(
                //     textEditingController: medium,
                //     validation: (value) {
                //       if (value == null || value.isEmpty) {
                //         return "Enter Medium";
                //       }
                //       return null;
                //     },
                //     hintText: "Medium",
                //     color: const Color(0xff585A60)),

                SizedBox(height: 8.h),
                Text(
                  "Portfilio Link",
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(fontSize: 13),
                ),
                SizedBox(height: 2.h),
                MyTextField(
                    textEditingController: portfiliolink,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Portfilio Link";
                      }
                      return null;
                    },
                    hintText: "Portfilio Link",
                    color: const Color(0xff585A60)),
                SizedBox(height: 8.h),

                 Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Show About",
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(fontSize: 13),
                    ),
                    Transform.scale(
                      scale: .7,
                      alignment: Alignment.center,
                      child: CupertinoSwitch(
                        
                        value: notesShow,
                        onChanged: (value) {
                          notesShow = value;
                          setState(
                            () {},
                          );
                        },
                        trackColor: CupertinoColors.systemGrey,
                        thumbColor: CupertinoColors.systemGrey5,
                        activeColor: Colors.blue,
                      ),
                    ),
                  ],
                ),
                MyTextField(
                    textEditingController: notes,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter About";
                      }
                      return null;
                    },
                    hintText: "About",
                    color: const Color(0xff585A60)),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: RoundedButton(
                      ontap: () {
                        submit();
                      },
                      title: "Save",
                      color: Theme.of(context).primaryColor,
                      textcolor: AppTheme.darkTextColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showModalChangeProfilePic(context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) {
          return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (() {
                //     Navigator.of(context).pop();
              }),
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0),
                    ),
                  ),
                  // alignment: Alignment.center,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 14.h,
                        ),
                        Center(
                          child: Container(
                            width: 40.w,
                            height: 5.h,
                            decoration: BoxDecoration(
                                color: Colors.grey[600],
                                borderRadius: BorderRadius.circular(16)),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Text(" Change Profile Picture",
                              style:
                                  Theme.of(context).textTheme.displayMedium!),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              getImageCamera(ImageSource.gallery);
                            },
                            child: Row(
                              children: [
                                Icon(Icons.image_outlined),
                                Container(
                                  child: Text("  Choose from Gallery",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge!),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              getImageCamera(ImageSource.camera);
                            },
                            child: Row(
                              children: [
                                Icon(Icons.camera_alt),
                                Container(
                                  child: Text("  Take a Photo",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge!),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                      ]),
                ),
              ));
        });
  }
}
