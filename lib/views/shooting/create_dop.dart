import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sica/components/dynamic_modal_sheet.dart';
import 'package:sica/models/ProjectTitle.dart';
import 'package:sica/models/ShootingModel.dart';
import 'package:sica/services/member_repo.dart';
import 'package:sica/utils/config.dart';
import 'package:sica/views/home/dashboard.dart';
import 'package:sica/views/profile/add_work.dart';
import 'package:sica/views/shooting/add_associate.dart';
import 'package:sica/views/shooting/dop_list.dart';
import '../../components/buton.dart';
import '../../components/input_feild.dart';
import 'package:sica/models/OtherMemberProfile.dart';
import '../../theme/theme.dart';
import '../login/otp_page.dart';
import 'package:intl/intl.dart';

class CreateDOP extends StatefulWidget {
  const CreateDOP({super.key, required this.associateList});
  final List associateList;
  @override
  State<CreateDOP> createState() => _CreateDOPState();
}

class _CreateDOPState extends State<CreateDOP> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List associate = [];
  List oldassociate = [];
  final date = TextEditingController();
  final mobile = TextEditingController();

  final name = TextEditingController();

  final memberno = TextEditingController();

  final designation = TextEditingController();

  final medium = TextEditingController();

  final projecttitle = TextEditingController();

  final startDate = TextEditingController();

  final endDate = TextEditingController();

  final notes = TextEditingController();
  final location = TextEditingController();
  final shooting = TextEditingController();
  final outdoorLink = TextEditingController();
  final producer = TextEditingController();
  final producerExt = TextEditingController();
  final producerExtContact = TextEditingController();
  final proHouse = TextEditingController();
  @override
  void initState() {
    super.initState();
    getMedium();
    getMemberAllData();
    getDopList();
  }

  Future<bool> onWillPop() async {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => MyDashBoard(currentIndex: 0)),
        (_) => false);
    return false;
  }

  List<ShootingAllDetails>? dopList;
  void getDopList() {
    final service = MemberRepo();
    service.getShootings().then((value) {
      if (value.isNotEmpty) {
        dopList = value.first.shootingAllDetails;
        // print(dopList!.first.shootingDetails!.designation);
        if (mounted) setState(() {});
      }
    });
  }

  submit() {
    if (_formKey.currentState!.validate()) {
      final service = MemberRepo();
      DialogHelp.showLoading(context);
      service
          .submitDop(
              date.text,
              mobile.text,
              name.text,
              memberno.text,
              designation.text,
              projecttitle.text,
              mediumid!,
              startDate.text,
              endDate.text,
              outdoorLink.text,
              producer.text,
              producerExtContact.text,
              location.text,
              proHouse.text,
              producerExt.text,
              associate)
          .then((value) {
        DialogHelp().hideLoading(context);
        if (value.isNotEmpty) {
          Fluttertoast.showToast(
              msg: "Dop Added",
              backgroundColor: Colors.green,
              gravity: ToastGravity.TOP,
              textColor: Colors.white);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      MyDashBoard(currentIndex: 0)),
              (_) => false);
          return false;
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
        () => searchOnStoppedTyping = new Timer(duration, () => search(value)));
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
        designation.text = memberBasicDetails2!.first.memberDetails!.grade!;
      } else {
        mobile.clear();
        name.clear();
        designation.clear();
      }
    } else {
      mobile.clear();
      name.clear();
      designation.clear();
    }
  }

  Timer? searchOnProjectyping;

  _onChangeProjectTiHandler(value) {
    const duration = Duration(
        milliseconds:
            800); // set the duration that you want call search() after that.
    if (searchOnProjectyping != null) {
      setState(() => searchOnProjectyping!.cancel()); // clear timer
    }
    setState(() =>
        searchOnProjectyping = Timer(duration, () => getProjectTitle(value)));
  }

  String? projectid;
  List<ProjectTitle> projectTitleList = [];
  void getProjectTitle(sss) {
    final service = MemberRepo();
    service.getProjectTitle(sss).then((value) {
      if (value.isNotEmpty) {
        projectTitleList = value;
        oldassociate = [];

        for (int i = 0;
            i < projectTitleList.first.shootingAllDetails!.length;
            i++) {
          Map<String, dynamic> json = {
            'name':
                '${projectTitleList.first.shootingAllDetails![i].shootingDetails!.memberName.toString()}',
            'mobile_number':
                '${projectTitleList.first.shootingAllDetails![i].shootingDetails!.mobileNumber.toString()}',
            'member_number':
                '${projectTitleList.first.shootingAllDetails![i].shootingDetails!.memberNumber.toString()}',
            'role':
                '${projectTitleList.first.shootingAllDetails![i].shootingDetails!.designation.toString()}',
          };
          oldassociate.add(json);
        }
        if (mounted) setState(() {});
      } else {
        oldassociate = [];
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        //   backgroundColor: AppTheme.whiteBackgroundColor,
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 1,
          centerTitle: false,
          title: const Text("Update DOP"),
          actions: [
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => DOPList()));
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
                  MyTextField(
                      readOnly: true,
                      textEditingController: date,
                      ontap: () async {
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
                      textEditingController: designation,
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
                      onChanged: _onChangeProjectTiHandler,
                      hintText: "Project Title",
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

                  // if (dopList != null)
                  //   if (dopList!.isNotEmpty)
                  //     MyTextField(
                  //         textEditingController: shooting,
                  //         readOnly: true,
                  //         validation: (value) {
                  //           if (value == null || value.isEmpty) {
                  //             return "Select Shooting";
                  //           }
                  //           return null;
                  //         },
                  //         ontap: () {
                  //           showModal();
                  //         },
                  //         icon: Icon(
                  //           Icons.arrow_drop_down,
                  //           color: Color(0xff585A60),
                  //         ),
                  //         hintText: "Select Shooting",
                  //         color: const Color(0xff585A60)),
                  SizedBox(height: 6.h),
                  MyTextField(
                      readOnly: true,
                      textEditingController: startDate,
                      ontap: () async {
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
                          startDate.text =
                              formattedDate; //set output date to TextField value.
                          setState(() {});
                        } else {
                          print("Start from date is not selected");
                        }
                      },
                      // textEditingController: _controller.emailController,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Schedule start";
                        }
                        return null;
                      },
                      icon: Icon(
                        Icons.calendar_month,
                        color: Color(0xff585A60),
                      ),
                      hintText: "Schedule start",
                      color: const Color(0xff585A60)),
                  SizedBox(height: 6.h),
                  MyTextField(
                      readOnly: true,
                      textEditingController: endDate,
                      ontap: () async {
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
                          endDate.text =
                              formattedDate; //set output date to TextField value.
                        } else {
                          print("end from date is not selected");
                        }
                      },
                      // textEditingController: _controller.emailController,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Schedule end";
                        }
                        return null;
                      },
                      icon: Icon(
                        Icons.calendar_month,
                        color: Color(0xff585A60),
                      ),
                      hintText: "Schedule end",
                      color: const Color(0xff585A60)),
                  SizedBox(height: 6.h),
                  // MyTextField(
                  //     textEditingController: medium,
                  //     readOnly: true,
                  //     ontap: () {
                  //       Navigator.of(context)
                  //           .push(MaterialPageRoute(
                  //               builder: (context) => AddWork()))
                  //           .then((value) {
                  //         if (value != null) {
                  //           associate = value;
                  //           setState(() {});
                  //         }
                  //       });
                  //     },
                  //     icon: Icon(
                  //       Icons.add,
                  //       color: Color(0xff585A60),
                  //     ),
                  //     hintText: "Add DOP team",
                  //     color: const Color(0xff585A60)),

                  RoundedButton(
                      ontap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (context) => AddWork()))
                            .then((value) {
                          if (value != null) {
                            associate = value;
                            setState(() {});
                          }
                        });
                      },
                      height: 37,
                      title: "+ Add DOP Team",
                      fontweigth: FontWeight.w600,
                      color: Theme.of(context).primaryColor,
                      textcolor: AppTheme.darkTextColor),

                  SizedBox(height: 12.h),
                  MyTextField(
                      textEditingController: producer,
                      fillcolor: Theme.of(context).cardColor,
                      hintText: "Enter Producer name",
                      color: const Color(0xff585A60)),
                  SizedBox(height: 5.h),

                  MyTextField(
                      textEditingController: proHouse,
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
                      textEditingController: location,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Location";
                        }
                        return null;
                      },
                      fillcolor: Theme.of(context).cardColor,
                      hintText: "Enter Location",
                      color: const Color(0xff585A60)),
                  SizedBox(height: 5.h),

                  MyTextField(
                      textEditingController: outdoorLink,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Outdoor Unit Name";
                        }
                        return null;
                      },
                      fillcolor: Theme.of(context).cardColor,
                      hintText: "Enter Outdoor Unit Name",
                      color: const Color(0xff585A60)),
                  // MyTextField(
                  //     textEditingController: notes,
                  //     validation: (value) {
                  //       if (value == null || value.isEmpty) {
                  //         return "Enter Outdoor link details";
                  //       }
                  //       return null;
                  //     },
                  //     hintText: "Outdoor link",
                  //     color: const Color(0xff585A60)),

                  if (associate.isNotEmpty)
                    ListView.builder(
                      itemCount: associate.length,
                      primary: false,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10.h),
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.3),
                                    width: 1)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${associate[index]["name"]}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(fontSize: 15),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                        "${associate[index]["role"]}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(fontSize: 13),
                                      ),
                                      SizedBox(
                                        height: 6.h,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.phone,
                                            size: 16,
                                            color:
                                                AppTheme.whiteBackgroundColor,
                                          ),
                                          SizedBox(
                                            width: 6,
                                          ),
                                          Text(
                                              "${associate[index]["mobile_number"]}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall!
                                                  .copyWith(
                                                    fontSize: 14,
                                                  )),
                                        ],
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
                                      "M No. ${associate[index]['member_number']}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              fontSize: 13,
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  if (oldassociate.isNotEmpty)
                    ListView.builder(
                      itemCount: oldassociate.length,
                      primary: false,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10.h),
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.3),
                                    width: 1)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${oldassociate[index]["name"]}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(fontSize: 15),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                        "${oldassociate[index]["role"]}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(fontSize: 13),
                                      ),
                                      SizedBox(
                                        height: 6.h,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.phone,
                                            size: 16,
                                            color:
                                                AppTheme.whiteBackgroundColor,
                                          ),
                                          SizedBox(
                                            width: 6,
                                          ),
                                          Text(
                                              "${oldassociate[index]["mobile_number"]}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall!
                                                  .copyWith(
                                                    fontSize: 14,
                                                  )),
                                        ],
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
                                      "M No. ${oldassociate[index]['member_number']}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              fontSize: 13,
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
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
      ),
    );
  }

  String? selValue;
  void showModal() {
    showModalBottomSheet(
        context: context,
        enableDrag: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0.r),
            topRight: Radius.circular(10.0.r),
          ),
        ),
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        // useSafeArea: true,
        builder: (context) {
          return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (() {
                //  Navigator.of(context).pop();
              }),
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    // Icon(
                    //   Icons.remove,
                    //   color: Colors.grey[600],
                    //   size: 40,
                    // ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                          color: Colors.grey[600],
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: dopList!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 12.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      dopList![index]
                                          .shootingDetails!
                                          .projectTitle!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(fontSize: 15),
                                    ),
                                    if (dopList![index]
                                            .shootingDetails!
                                            .shootingId!
                                            .toString() ==
                                        selValue)
                                      Icon(CupertinoIcons.checkmark,
                                          size: 24, color: Colors.blue)
                                    // Container(
                                    //   decoration: BoxDecoration(
                                    //       shape: BoxShape.circle,
                                    //       border: Border.all(
                                    //         color: Theme.of(context)
                                    //             .canvasColor,
                                    //       )),
                                    //       alignment: Alignment.center,
                                    //   child: Padding(
                                    //     padding: const EdgeInsets.all(2),
                                    //     child: Icon(Icons.circle,
                                    //         size: 10,
                                    //         color: Colors.blue),
                                    //   ),
                                    // )
                                  ],
                                ),
                              ),
                              onTap: () {
                                // Get.find<AccountSetUpController>()
                                //     .setAccountValue(items[index]);
                                //    _controller.accountType.value =  TextEditingController(text: _items[index]);

                                selValue = dopList![index]
                                    .shootingDetails!
                                    .shootingId!
                                    .toString();
                                shooting.text = dopList![index]
                                    .shootingDetails!
                                    .projectTitle!
                                    .toString();
                                setState(() {});
                                Navigator.pop(context);
                              });
                        }),
                    SizedBox(
                      height: 10.h,
                    ),
                  ]),
                ),
              ));
        });
  }
}
