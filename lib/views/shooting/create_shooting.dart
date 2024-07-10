import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sica/components/dynamic_modal_sheet.dart';
import 'package:sica/models/OtherMemberProfile.dart';
import 'package:sica/models/ShootingUpdateModel.dart';
import 'package:sica/services/member_repo.dart';
import 'package:sica/utils/config.dart';
import 'package:sica/views/home/dashboard.dart';
import 'package:sica/views/profile/add_work.dart';
import 'package:sica/views/shooting/shooting_list.dart';
import '../../components/buton.dart';
import '../../components/input_feild.dart';
import '../../theme/theme.dart';
import '../login/otp_page.dart';
import 'package:intl/intl.dart';

class CreateShooting extends StatefulWidget {
  CreateShooting({super.key, required this.updatesShot});
  final MemberShooting updatesShot;
  @override
  State<CreateShooting> createState() => _CreateShootingState();
}

class _CreateShootingState extends State<CreateShooting> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final dopname = TextEditingController();
  final dopmemno = TextEditingController();
  final mobile = TextEditingController();
  final date = TextEditingController();
  final name = TextEditingController();
  final producer = TextEditingController();
  final producerExt = TextEditingController();
  final producerExtContact = TextEditingController();
  final proHouse = TextEditingController();
  final memberno = TextEditingController();
  List postTypes = [
    {"type": "Operative Cameraman"},
    {"type": "Associate  Cameraman"},
    {"type": "Assistant Cameraman"},
    {"type": "2nd Unit Cameraman"},
    {"type": "1st Unit  Cameraman"},
  ];
  final designation = TextEditingController();
  final grade = TextEditingController();
  final medium = TextEditingController();
  String? updateid;
  final projecttitle = TextEditingController();

  final outdoor = TextEditingController();

  final locaion = TextEditingController();

  //final approvalTypeText = TextEditingController();
  final notes = TextEditingController();
  List approvalType = [
    {"ans": "Yes"},
    {"ans": "No"}
  ];
  @override
  void initState() {
    getMedium();
    getMemberAllData();
    super.initState();
    getShootingImage();
    if (widget.updatesShot.updateShooingId != null) {
      updateid = widget.updatesShot.updateShooingId.toString();
      memberno.text = widget.updatesShot.memberNumber.toString();
      grade.text = widget.updatesShot.grade.toString();
      name.text = widget.updatesShot.memberName.toString();
      mobile.text = widget.updatesShot.mobileNumber.toString();
      designation.text = widget.updatesShot.designation.toString();
      projecttitle.text = widget.updatesShot.projectTitle.toString();
      dopmemno.text = widget.updatesShot.dopNumber.toString();
      dopname.text = widget.updatesShot.dopName.toString();

      producer.text = widget.updatesShot.producer.toString();
      producerExt.text = widget.updatesShot.productionExecutive.toString();
      notes.text = widget.updatesShot.notes.toString();
      grade.text = widget.updatesShot.grade.toString();
      proHouse.text = widget.updatesShot.productionHouse.toString();
      locaion.text = widget.updatesShot.location.toString();
      outdoor.text = widget.updatesShot.outdoorUnitName.toString();
      date.text = widget.updatesShot.date.toString();
      producerExtContact.text =
          widget.updatesShot.productionExecutiveContactNo.toString();
      //  List aa=   mediumList
      //         .where((value) =>
      //             value["format_id"].toString() ==
      //             widget.updatesShot.mediumId.toString())
      //         .toList();
      //         medium.text=aa[0]["format_name"];
      setState(() {});
    }
  }

//shooting_title
  List<MemberBasicDetails>? memberBasicDetails;
  List<MemberBasicDetails>? memberBasicDetails2;
  Future<void> getMemberAllData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final rawJson = sharedPreferences.getString('memberList') ?? '';
    var jsonMap = json.decode(rawJson);
    memberBasicDetails = List<MemberBasicDetails>.from(
        jsonMap.map((x) => MemberBasicDetails.fromJson(x)));
    memberBasicDetails2 = memberBasicDetails;
    print("loaded");
  }

  Timer? searchOnStoppedTyping;
  _onChangeHandler(value) {
    const duration = Duration(
        milliseconds:
            800); // set the duration that you want call search() after that.
    if (searchOnStoppedTyping != null) {
      setState(() => searchOnStoppedTyping!.cancel()); // clear timer
    }
    setState(
        () => searchOnStoppedTyping = Timer(duration, () => search(value)));
  }

  search(value) {
    print(value);
    if (value.isNotEmpty) {
      memberBasicDetails2 = memberBasicDetails!
          .where((elem) =>
              elem.memberDetails!.membershipNo!.toString() == value.toString())
          .toList();
      if (memberBasicDetails2!.isNotEmpty) {
        mobile.text = memberBasicDetails2!.first.memberDetails!.mobileNumber!;
        name.text = memberBasicDetails2!.first.memberDetails!.name!;
        grade.text = memberBasicDetails2!.first.memberDetails!.grade!;
      } else {
        mobile.clear();
        name.clear();
        grade.clear();
      }
    } else {
      mobile.clear();
      name.clear();
      grade.clear();
    }
  }

  submit() {
    if (_formKey.currentState!.validate()) {
      final service = MemberRepo();
      DialogHelp.showLoading(context);
      service
          .submitShooting(
              dopname.text,
              dopmemno.text,
              producer.text,
              proHouse.text,
              producerExt.text,
              producerExtContact.text,
              mobile.text,
              name.text,
              memberno.text,
              designation.text,
              projecttitle.text,
              mediumid!,
              date.text,
              grade.text,
              notes.text,
              locaion.text,
              outdoor.text)
          .then((value) {
        DialogHelp().hideLoading(context);
        if (value.isNotEmpty) {
          Fluttertoast.showToast(
              msg: "Shooting Updated",
              backgroundColor: Colors.green,
              gravity: ToastGravity.TOP,
              textColor: Colors.white);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      MyDashBoard(currentIndex: 0)),
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

  String? mediumid;
  List mediumList = [];
  void getMedium() {
    final service = MemberRepo();
    service.getMediumService().then((value) {
      if (value.isNotEmpty) {
        mediumList = value;
        if (mounted) setState(() {});
      }
    });
  }

  List shootingImages = [];
  void getShootingImage() {
    final service = MemberRepo();
    service.getShootingImages().then((value) {
      if (value.isNotEmpty) {
        shootingImages = value;
        if (mounted) setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   backgroundColor: AppTheme.whiteBackgroundColor,
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 1,
        centerTitle: false,
        title: const Text("Update Shooting"),
        actions: [
          if (updateid == null)
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ShootingList()));
                },
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                      color: AppTheme.yelloDarkColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    "History",
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
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (shootingImages.isNotEmpty)
                  Image.network(
                    shootingImages[0][0]["image_url"],
                    fit: BoxFit.contain,
                  ),
                if (shootingImages.isNotEmpty) SizedBox(height: 12.h),
                if (shootingImages.isNotEmpty)
                  Text(shootingImages[0][0]["title"],
                      style: Theme.of(context).textTheme.headlineMedium!),
                SizedBox(height: 12.h),
                MyTextField(
                    readOnly: true,
                    textEditingController: date,
                    ontap: () async {
                      if (updateid != null) {
                        return;
                      }
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));

                      if (pickedDate != null) {
                        print(pickedDate);
                        String formattedDate =
                            DateFormat('dd/MM/yyyy').format(pickedDate);
                        print(formattedDate);
                        date.text =
                            formattedDate; //set output date to TextField value.
                        setState(() {});
                      } else {
                        print("Start from date is not selected");
                      }
                    },
                    // textEditingController: _controller.emailController,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Date";
                      }
                      return null;
                    },
                    icon: Icon(
                      Icons.calendar_month,
                      color: Color(0xff585A60),
                    ),
                    hintText: "Select Date",
                    color: const Color(0xff585A60)),
                SizedBox(height: 6.h),
                // ),
                MyTextField(
                    textEditingController: memberno,
                    readOnly: updateid != null,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Membership Number";
                      }
                      return null;
                    },
                    textInputType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: _onChangeHandler,
                    hintText: "Membership Number",
                    color: const Color(0xff585A60)),
                SizedBox(height: 6.h),
                MyTextField(
                    textEditingController: mobile,
                    readOnly: updateid != null,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Mobile Number";
                      }
                      return null;
                    },
                    fillcolor: Theme.of(context).cardColor,
                    hintText: "Mobile number",
                    color: const Color(0xff585A60)),
                SizedBox(height: 6.h),
                MyTextField(
                    textEditingController: name,
                    readOnly: updateid != null,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Name";
                      }
                      return null;
                    },
                    hintText: "Name",
                    color: const Color(0xff585A60)),
                SizedBox(height: 6.h),

                MyTextField(
                    textEditingController: grade,
                    readOnly: updateid != null,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Grade";
                      }
                      return null;
                    },
                    hintText: "Grade",
                    color: const Color(0xff585A60)),
                SizedBox(height: 6.h),
                MyTextField(
                    textEditingController: projecttitle,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Project Title";
                      }
                      return null;
                    },
                    readOnly: updateid != null,
                    hintText: "Project Title",
                    color: const Color(0xff585A60)),
                SizedBox(height: 6.h),

                MyTextField(
                    textEditingController: dopname,
                    readOnly: updateid != null,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter DOP name";
                      }
                      return null;
                    },
                    // onChanged: _onChangeProjectTiHandler,
                    hintText: "DOP name",
                    color: const Color(0xff585A60)),
                SizedBox(height: 6.h),
                SizedBox(height: 6.h),
                MyTextField(
                    textEditingController: dopmemno,
                    readOnly: updateid != null,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter DOP Member number";
                      }
                      return null;
                    },
                    // onChanged: _onChangeProjectTiHandler,
                    hintText: "DOP Member number",
                    color: const Color(0xff585A60)),
                SizedBox(height: 6.h),
                if (mediumList.isNotEmpty)
                  MyTextField(
                      textEditingController: medium,
                      readOnly: true,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return "Select Format";
                        }
                        return null;
                      },
                      ontap: () {
                        if (updateid != null) {
                          return;
                        }
                        ModalSheet.showModal(
                            context, mediumList[0], "format_name", (value) {
                          setState(() {
                            medium.text = value;
                          });
                        }, (value) {
                          mediumid =
                              mediumList[0][value]["format_id"].toString();
                          setState(() {});
                        }, medium.text);
                      },
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Color(0xff585A60),
                      ),
                      hintText: "Select Format",
                      color: const Color(0xff585A60)),
                SizedBox(height: 6.h),

                MyTextField(
                    textEditingController: designation,
                    readOnly: true,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Select Designation";
                      }
                      return null;
                    },
                    ontap: () {
                      if (updateid != null) {
                        return;
                      }
                      ModalSheet.showModal(context, postTypes, "type", (value) {
                        setState(() {
                          designation.text = value;
                        });
                      }, (value) {
                        setState(() {});
                      }, designation.text);
                    },
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Color(0xff585A60),
                    ),
                    hintText: "Select Designation",
                    color: const Color(0xff585A60)),
                SizedBox(height: 6.h),
                // SizedBox(height: 6.h),
                // MyTextField(
                //     textEditingController: approvalTypeText,
                //     readOnly: true,
                //     validation: (value) {
                //       if (value == null || value.isEmpty) {
                //         return "Select DOP for approval";
                //       }
                //       return null;
                //     },
                //     ontap: () {
                //       ModalSheet.showModal(context, approvalType, "ans",
                //           (value) {
                //         //  print(value);
                //         //sss _controller.setMode(value);
                //         setState(() {
                //           approvalTypeText.text = value;
                //         });
                //       }, (value) {}, approvalTypeText.text);
                //     },
                //     icon: Icon(
                //       Icons.arrow_drop_down,
                //       color: Color(0xff585A60),
                //     ),
                //     hintText: "Select DOP for approval",
                //     color: const Color(0xff585A60)),

                // MyTextField(
                //     readOnly: true,
                //     textEditingController: startDate,
                //     ontap: () async {
                //       DateTime? pickedDate = await showDatePicker(
                //           context: context,
                //           initialDate: DateTime.now(),
                //           firstDate: DateTime(2000),
                //           lastDate: DateTime(2101));

                //       if (pickedDate != null) {
                //         print(pickedDate);
                //         String formattedDate =
                //             DateFormat('dd/MM/yyyy').format(pickedDate);
                //         print(formattedDate);
                //         startDate.text =
                //             formattedDate; //set output date to TextField value.
                //         setState(() {});
                //       } else {
                //         print("Start from date is not selected");
                //       }
                //     },
                //     // textEditingController: _controller.emailController,
                //     validation: (value) {
                //       if (value == null || value.isEmpty) {
                //         return "Enter Start Date";
                //       }
                //       return null;
                //     },
                //     icon: Icon(
                //       Icons.calendar_month,
                //       color: Color(0xff585A60),
                //     ),
                //     hintText: "Start Date",
                //     color: const Color(0xff585A60)),
                // SizedBox(height: 6.h),
                // MyTextField(
                //     readOnly: true,
                //     textEditingController: endDate,
                //     ontap: () async {
                //       DateTime? pickedDate = await showDatePicker(
                //           context: context,
                //           initialDate: DateTime.now(),
                //           firstDate: DateTime(2000),
                //           lastDate: DateTime(2101));

                //       if (pickedDate != null) {
                //         print(pickedDate);
                //         String formattedDate =
                //             DateFormat('dd/MM/yyyy').format(pickedDate);
                //         print(formattedDate);
                //         endDate.text =
                //             formattedDate; //set output date to TextField value.
                //       } else {
                //         print("end from date is not selected");
                //       }
                //     },
                //     // textEditingController: _controller.emailController,
                //     validation: (value) {
                //       if (value == null || value.isEmpty) {
                //         return "Enter End Date";
                //       }
                //       return null;
                //     },
                //     icon: Icon(
                //       Icons.calendar_month,
                //       color: Color(0xff585A60),
                //     ),
                //     hintText: "End Date",
                //     color: const Color(0xff585A60)),
                // SizedBox(height: 6.h),
                SizedBox(height: 6.h),
                MyTextField(
                    textEditingController: producer,
                    readOnly: updateid != null,
                    fillcolor: Theme.of(context).cardColor,
                    hintText: "Enter Producer name",
                    color: const Color(0xff585A60)),
                SizedBox(height: 5.h),

                MyTextField(
                    textEditingController: proHouse,
                    readOnly: updateid != null,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Production House";
                      }
                      return null;
                    },
                    fillcolor: Theme.of(context).cardColor,
                    hintText: "Enter Production House",
                    color: const Color(0xff585A60)),
                SizedBox(height: 5.h),

                MyTextField(
                    textEditingController: producerExt,
                    readOnly: updateid != null,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Production Executive/Manager name";
                      }
                      return null;
                    },
                    fillcolor: Theme.of(context).cardColor,
                    hintText: "Enter Production Executive/Manager name",
                    color: const Color(0xff585A60)),
                SizedBox(height: 5.h),

                MyTextField(
                    textEditingController: producerExtContact,
                    readOnly: updateid != null,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Production Executive/Manager - Contact No.";
                      }
                      return null;
                    },
                    fillcolor: Theme.of(context).cardColor,
                    hintText:
                        "Enter Production Executive/Manager - Contact No.",
                    color: const Color(0xff585A60)),
                SizedBox(height: 5.h),
                MyTextField(
                    readOnly: updateid != null,
                    textEditingController: locaion,
                    hintText: "Location",
                    color: const Color(0xff585A60)),
                SizedBox(height: 5.h),
                MyTextField(
                    textEditingController: outdoor,
                    readOnly: updateid != null,
                    hintText: "Outdoor Unit name",
                    color: const Color(0xff585A60)),
                SizedBox(height: 5.h),
                // MyTextField(
                //     textEditingController: notes,
                //     readOnly: updateid != null,
                //     hintText: "Notes",
                //     color: const Color(0xff585A60)),

                Row(
                  children: [
                    Flexible(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: 25.0,
                          maxHeight: 135.0,
                        ),
                        child: Scrollbar(
                          child: TextField(
                            cursorColor: Colors.blue,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            style:
                                TextStyle(color: AppTheme.whiteBackgroundColor),
                            controller: notes,
                            maxLength: 1000,
                            //   _handleSubmitted : null,
                            decoration: InputDecoration(
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                      color: AppTheme.hintTextColor,
                                      fontSize: 13),
                              counterStyle: TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.whiteBackgroundColor),
                              fillColor: const Color(0xFF121212),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppTheme.hintTextColor),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppTheme.hintTextColor),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppTheme.hintTextColor),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              contentPadding: EdgeInsets.only(
                                  top: 2.0,
                                  left: 13.0,
                                  right: 13.0,
                                  bottom: 2.0),
                              hintText: "Type your notes",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (updateid == null)
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.h, horizontal: 12),
                    child: RoundedButton(
                        ontap: () {
                          submit();
                        },
                        title: "Apply",
                        height: 40,
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
}
