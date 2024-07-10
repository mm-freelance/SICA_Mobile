import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sica/services/member_repo.dart';
import 'package:sica/utils/config.dart';
import 'package:sica/views/home/dashboard.dart';
import 'package:sica/views/profile/add_work.dart';
import '../../components/buton.dart';
import '../../components/dynamic_modal_sheet.dart';
import '../../components/input_feild.dart';

import '../../models/OtherMemberProfile.dart';
import '../../theme/theme.dart';
import '../login/otp_page.dart';
import 'package:intl/intl.dart';

class CreateShootingReport extends StatefulWidget {
  CreateShootingReport({super.key, required this.reasonid});
  final String reasonid;
  @override
  State<CreateShootingReport> createState() => _CreateDelayReportState();
}

class _CreateDelayReportState extends State<CreateShootingReport> {
  final categoryText = TextEditingController();
  final designationText = TextEditingController();
  final formatText = TextEditingController();
  final name = TextEditingController();
  final memberno = TextEditingController();
  final project = TextEditingController();
  final contact = TextEditingController();
  final email = TextEditingController();
  final outdoor = TextEditingController();
  final location = TextEditingController();
  final outdoorLink = TextEditingController();
  final producer = TextEditingController();
  final producerExt = TextEditingController();
  final producerExtContact = TextEditingController();
  final proHouse = TextEditingController();

  List category = [
    {"ans": "Life"},
    {"ans": "Active"},
    {"ans": "Junior"},
    {"ans": "Associate"}
  ];
  List format = [
    {"ans": "Feature Film"},
    {"ans": "OTT - Series/ Film"},
    {"ans": "TV Serial"},
    {"ans": "OTT - Series/ Film"},
    {"ans": "Advertisement Film"},
    {"ans": "Reality Show - Non Fiction"}
  ];
  List designation = [
    {"ans": "Director of Photography"},
    {"ans": "2nd Unit Cameraman"},
    {"ans": "Operative Cameraman"},
    {"ans": "Associate Cameraman"},
    {"ans": "Assistant Cameraman"}
  ];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  submit() {
    if (_formKey.currentState!.validate()) {
      final service = MemberRepo();
      DialogHelp.showLoading(context);
      service
          .createShootingReason(
              widget.reasonid,
              memberno.text,
              name.text,
              contact.text,
              email.text,
              project.text,
              categoryText.text,
              formatText.text,
              designationText.text,
              producer.text,
              proHouse.text,
              producerExt.text,
              producerExtContact.text,
              outdoorLink.text,
              location.text)
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
 Timer? searchOnStoppedTyping;
  List<MemberBasicDetails>? memberBasicDetails;
  List<MemberBasicDetails>? memberBasicDetails2;
  @override
  void initState() {
    super.initState();
    getMemberAllData();
  }
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
        contact.text = memberBasicDetails2!.first.memberDetails!.mobileNumber!;
        name.text = memberBasicDetails2!.first.memberDetails!.name!;
      email.text = memberBasicDetails2!.first.memberDetails!.email!;
      } else {
        contact.clear();
        name.clear();
        email.clear();
      }
    } else {
      contact.clear();
      name.clear();
      email.clear();
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
        title: const Text("Daily Shooting update Report "),
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
                    "Member No",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13),
                  ),
                ),
                MyTextField(
                    textEditingController: memberno,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Member No";
                      }
                      return null;
                    },
                     textInputType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      onChanged: _onChangeHandler,
                    fillcolor: Theme.of(context).cardColor,
                    hintText: "Your answer",
                    color: const Color(0xff585A60)),
                SizedBox(height: 5.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 3.h),
                  child: Text(
                    "Member name",
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
                    "Email",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13),
                  ),
                ),
                MyTextField(
                    textEditingController: email,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Email";
                      }
                      return null;
                    },
                    hintText: "Your answer",
                    color: const Color(0xff585A60)),
                SizedBox(height: 5.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 3.h),
                  child: Text(
                    "Contact",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13),
                  ),
                ),
                MyTextField(
                    textEditingController: contact,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Contact";
                      }
                      return null;
                    },
                    hintText: "Your answer",
                    color: const Color(0xff585A60)),
                SizedBox(height: 5.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 3.h),
                  child: Text(
                    "Project Name",
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
                        return "Enter Project Name";
                      }
                      return null;
                    },
                    hintText: "Your answer",
                    color: const Color(0xff585A60)),
                SizedBox(height: 5.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 3.h),
                  child: Text(
                    "Category",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13),
                  ),
                ),
                MyTextField(
                    readOnly: true,
                    textEditingController: categoryText,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Category is required";
                      }
                      return null;
                    },
                    ontap: () {
                      ModalSheet.showModal(context, category, "ans", (value) {
                        //  print(value);
                        //sss _controller.setMode(value);
                        setState(() {
                          categoryText.text = value;
                        });
                      }, (value) {}, categoryText.text);
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
                    "Format",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13),
                  ),
                ),
                MyTextField(
                    textEditingController: formatText,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Format is required.";
                      }
                      return null;
                    },
                    ontap: () {
                      ModalSheet.showModal(context, format, "ans", (value) {
                        setState(() {
                          formatText.text = value;
                        });
                      }, (value) {}, formatText.text);
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
                    "Designation",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13),
                  ),
                ),
                MyTextField(
                    textEditingController: designationText,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Designation is required";
                      }
                      return null;
                    },
                    ontap: () {
                      ModalSheet.showModal(context, designation, "ans",
                          (value) {
                        setState(() {
                          designationText.text = value;
                        });
                      }, (value) {}, designationText.text);
                    },
                    readOnly: true,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Color(0xff585A60),
                    ),
                    hintText: "Your answer",
                    color: const Color(0xff585A60)),
                Padding(
                  padding: EdgeInsets.only(bottom: 3.h),
                  child: Text(
                    "Producer",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13),
                  ),
                ),
                MyTextField(
                    textEditingController: producer,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Producer";
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
                    "Production House",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13),
                  ),
                ),
                MyTextField(
                    textEditingController: proHouse,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Production House";
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
                    "Production Executive",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13),
                  ),
                ),
                MyTextField(
                    textEditingController: producerExt,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Production Executive";
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
                    "Production Executive - Contact No.",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13),
                  ),
                ),
                MyTextField(
                    textEditingController: producerExtContact,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Production Executive - Contact No.";
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
                    "Location",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13),
                  ),
                ),
                MyTextField(
                    textEditingController: location,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Location";
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
                    "Outdoor Unit Name",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13),
                  ),
                ),
                MyTextField(
                    textEditingController: outdoorLink,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Outdoor Unit Name";
                      }
                      return null;
                    },
                    fillcolor: Theme.of(context).cardColor,
                    hintText: "Your answer",
                    color: const Color(0xff585A60)),
                SizedBox(height: 5.h),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
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
