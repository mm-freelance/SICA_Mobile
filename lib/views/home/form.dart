import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sica/models/OtherMemberProfile.dart';
import 'package:sica/services/member_repo.dart';
import 'package:sica/utils/config.dart';
import 'package:sica/views/home/dashboard.dart';
import 'package:sica/views/profile/add_work.dart';
import '../../components/buton.dart';
import '../../components/dynamic_modal_sheet.dart';
import '../../components/input_feild.dart';
import '../../theme/theme.dart';
import '../login/otp_page.dart';
import 'package:intl/intl.dart';

class CreateDelayReport extends StatefulWidget {
  CreateDelayReport({super.key, required this.reasonid});
  final String reasonid;
  @override
  State<CreateDelayReport> createState() => _CreateDelayReportState();
}

class _CreateDelayReportState extends State<CreateDelayReport> {
  String radioButtonItem = 'Yes';
  final cameraIssueText = TextEditingController();
  final outdorrIssueText = TextEditingController();
  final issueTypeText = TextEditingController();
  final name = TextEditingController();
  final memberno = TextEditingController();
  final project = TextEditingController();
  final production = TextEditingController();
  final outdoor = TextEditingController();
  final location = TextEditingController();
  final issue = TextEditingController();
  final aproxTime = TextEditingController();
  final managerContact = TextEditingController();
  final productionContact = TextEditingController();
  final briefIssue = TextEditingController();
  List issueType = [
    {"ans": "Yes"},
    {"ans": "No"}
  ];
  List outdorrIssue = [
    {"ans": "Yes"},
    {"ans": "No"}
  ];
  List CameraIssue = [
    {"type": "Camera"},
    {"type": "Lens"},
    {"type": "Lights"},
    {"type": "Grips"}
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMemberAllData();
  }
   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  submit() {
    if (_formKey.currentState!.validate()) {
      final service = MemberRepo();
      DialogHelp.showLoading(context);
      service
          .createReason(
            widget.reasonid,
              memberno.text,
              name.text,
              project.text,
              production.text,
              outdoor.text,
              location.text,
              cameraIssueText.text,
              aproxTime.text,
              managerContact.text,
              outdorrIssueText.text,
            issueTypeText.text,
              productionContact.text,
              briefIssue.text)
          .then((value) {
        DialogHelp().hideLoading(context);
        if (value.isNotEmpty) {
          Fluttertoast.showToast(
              msg: "Grievance Added",
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
   List<MemberBasicDetails>? memberBasicDetails;
  List<MemberBasicDetails>? memberBasicDetails2;

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

  Future<void> getMemberAllData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final rawJson = sharedPreferences.getString('memberList') ?? '';
    var jsonMap = json.decode(rawJson);
    memberBasicDetails = List<MemberBasicDetails>.from(
        jsonMap.map((x) => MemberBasicDetails.fromJson(x)));
    memberBasicDetails2 = memberBasicDetails;
    print("loaded");
  }

  search(value) {
    print(value);
    if (value.isNotEmpty) {
      memberBasicDetails2 = memberBasicDetails!
          .where((elem) =>
              elem.memberDetails!.membershipNo!.toString() == value.toString())
          .toList();
      if (memberBasicDetails2!.isNotEmpty) {
      //  mobile.text = memberBasicDetails2!.first.memberDetails!.mobileNumber!;
        name.text = memberBasicDetails2!.first.memberDetails!.name!;
       // designation.text = memberBasicDetails2!.first.memberDetails!.grade!;
      } else {
     //   mobile.clear();
        name.clear();
       // designation.clear();
      }
    } else {
    //  mobile.clear();
      name.clear();
   //   designation.clear();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   backgroundColor: AppTheme.whiteBackgroundColor,
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 1,
        titleTextStyle: TextStyle(fontSize: 16),
        title: const Text("Shooting Equipment’s Delay Report "),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 3.h),
                  child: Text(
                    "MEMBER NO",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13),
                  ),
                ),
                MyTextField(
                  onChanged: _onChangeHandler,
                    textEditingController: memberno,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter MEMBER NAME & M.NO";
                      }
                      return null;
                    },
                    fillcolor: Theme.of(context).cardColor,
                    hintText: "Your answer",
                    color: const Color(0xff585A60)),
                SizedBox(height: 5.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 3.h),
                  child: Text(
                    "Name",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13),
                  ),
                ),
                MyTextField(
                     textEditingController: name,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Name";
                      }
                      return null;
                    },
                    hintText: "Your answer",
                    color: const Color(0xff585A60)),
                SizedBox(height: 5.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 3.h),
                  child: Text(
                    "PROJECT NAME",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13),
                  ),
                ),
                MyTextField(
                   textEditingController: project,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter PROJECT NAME";
                      }
                      return null;
                    },
                    hintText: "Your answer",
                    color: const Color(0xff585A60)),
                SizedBox(height: 5.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 3.h),
                  child: Text(
                    "PRODUCTION HOUSE NAME",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13),
                  ),
                ),
                MyTextField(
                   textEditingController: production,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter PRODUCTION HOUSE NAME";
                      }
                      return null;
                    },
                    hintText: "Your answer",
                    color: const Color(0xff585A60)),
                SizedBox(height: 5.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 3.h),
                  child: Text(
                    "OUTDOOR UNIT NAME",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13),
                  ),
                ),
                MyTextField(
                   textEditingController: outdoor,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter OUTDOOR UNIT NAME";
                      }
                      return null;
                    },
                    hintText: "Your answer",
                    color: const Color(0xff585A60)),
                SizedBox(height: 5.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 3.h),
                  child: Text(
                    "LOCATION",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13),
                  ),
                ),
                MyTextField(
                    textEditingController:location,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter LOCATION";
                      }
                      return null;
                    },
                    hintText: "Your answer",
                    color: const Color(0xff585A60)),
                SizedBox(height: 5.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 3.h),
                  child: Text(
                    "Issues Arised  in Camera & Lens or Lights or Grips",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13),
                  ),
                ),
                MyTextField(
                    readOnly: true,
                    textEditingController: cameraIssueText,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Issues Arised  in Camera & Lens or Lights or Grips";
                      }
                      return null;
                    },
                    ontap: () {
                      ModalSheet.showModal(context, CameraIssue, "type",
                          (value) {
                        //  print(value);
                        //sss _controller.setMode(value);
                        setState(() {
                          cameraIssueText.text = value;
                        });
                      }, (value) {}, cameraIssueText.text);
                    },
                    hintText: "Your answer",
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Color(0xff585A60),
                    ),
                    color: const Color(0xff585A60)),
                SizedBox(height: 5.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 3.h),
                  child: Text(
                    "Approximate Time Lost Due to the Problem",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13),
                  ),
                ),
                MyTextField(
                     textEditingController: aproxTime,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Approximate Time Lost Due to the Problem";
                      }
                      return null;
                    },
                    hintText: "Your answer",
                    color: const Color(0xff585A60)),
                SizedBox(height: 5.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 3.h),
                  child: Text(
                    "Name and Contact No of Outdoor Unit Manager",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13),
                  ),
                ),
                MyTextField(
                     textEditingController: managerContact,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Name and Contact No of Outdoor Unit Manager.";
                      }
                      return null;
                    },
                    hintText: "Your answer",
                    color: const Color(0xff585A60)),
                SizedBox(height: 5.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 3.h),
                  child: Text(
                    "Has Outdoor unit manager was helpful to solve the issue",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13),
                  ),
                ),
                MyTextField(
                    textEditingController: issueTypeText,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Has Outdoor unit manager was helpful to solve the issue.";
                      }
                      return null;
                    },
                    ontap: () {
                      ModalSheet.showModal(context, issueType, "ans", (value) {
                        setState(() {
                          issueTypeText.text = value;
                        });
                      }, (value) {}, issueTypeText.text);
                    },
                    readOnly: true,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Color(0xff585A60),
                    ),
                    hintText: "Your answer",
                    color: const Color(0xff585A60)),
                SizedBox(height: 5.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 3.h),
                  child: Text(
                    "Has the Issue been reported to the Production Manager / Executive Producer",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13),
                  ),
                ),
                MyTextField(
                    textEditingController: outdorrIssueText,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Has the Issue been reported to the Production Manager / Executive Producer";
                      }
                      return null;
                    },
                    ontap: () {
                      ModalSheet.showModal(context, outdorrIssue, "ans",
                          (value) {
                        setState(() {
                          outdorrIssueText.text = value;
                        });
                      }, (value) {}, outdorrIssueText.text);
                    },
                    readOnly: true,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Color(0xff585A60),
                    ),
                    hintText: "Your answer",
                    color: const Color(0xff585A60)),
                SizedBox(height: 5.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 3.h),
                  child: Text(
                    "Name and Contact No of the Production Manager / Executive Producer",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13),
                  ),
                ),
                MyTextField(
                     textEditingController:productionContact,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Name and Contact No of the Production Manager / Executive Producer.";
                      }
                      return null;
                    },
                    hintText: "Your answer",
                    color: const Color(0xff585A60)),
                SizedBox(height: 5.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 3.h),
                  child: Text(
                    "Brief the issues you faced with the service of Outdoor  Unit / Equipments",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13),
                  ),
                ),
                MyTextField(

                     textEditingController: issue,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Brief the issues you faced with the service of Outdoor  Unit / Equipments";
                      }
                      return null;
                    },
                    hintText: "Your answer",
                    color: const Color(0xff585A60)),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 26.h),
                  child: RoundedButton(
                      ontap: () {
                       submit();
                      },
                      title: "Submit",
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
