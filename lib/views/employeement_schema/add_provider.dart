import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sica/models/OtherMemberProfile.dart';
import 'package:sica/services/member_repo.dart';
import 'package:sica/utils/config.dart';
import 'package:sica/views/employeement_schema/job_provider.dart';
import 'package:sica/views/home/dashboard.dart';
import 'package:sica/views/profile/add_work.dart';
import '../../components/buton.dart';
import '../../components/dynamic_modal_sheet.dart';
import '../../components/input_feild.dart';
import '../../theme/theme.dart';
import '../login/otp_page.dart';

class AddProvider extends StatefulWidget {
  AddProvider({super.key});

  @override
  State<AddProvider> createState() => _AddProviderState();
}

class _AddProviderState extends State<AddProvider> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // List postTypes = [
  //   {"type": "Operative Cameraman"},
  //   {"type": "Associate  Cameraman"},
  //   {"type": "Assistant Cameraman"},
  //   {"type": "1st Unit  Cameraman"},
  //   {"type": "2nd Unit Cameraman"},
  //    {"type": "1st Unit  Cameraman"},
  //   {"type": "Director of photography"}
  // ];

  // List category = [
  //   {"ans": "Life"},
  //   {"ans": "Active"},
  //   {"ans": "Junior"},
  //   {"ans": "Associate"}
  // ];
  String formatId = "";
  String postAppyid = "";
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

  final mobile = TextEditingController();
  final available_start_date = TextEditingController();
  final available_end_date = TextEditingController();
  final name = TextEditingController();

  final memberno = TextEditingController();

  final designation = TextEditingController();

  // final skills = TextEditingController();

  final experience = TextEditingController();

  final medium = TextEditingController();

  final projectRequirement = TextEditingController();

  final notes = TextEditingController();
  final protfolioLink = TextEditingController();
  @override
  void initState() {
    super.initState();

    getMemberAllData();
    getMedium();
    getSkills();
    getJobList();
  }

  List skills = [];
  void getSkills() {
    final service = MemberRepo();
    service.getSkills().then((value) {
      if (value.isNotEmpty) {
        skills = value;
        if (mounted) setState(() {});
      }
    });
  }

  List jobList = [];
  void getJobList() {
    final service = MemberRepo();
    service.getJobPosts().then((value) {
      if (value.isNotEmpty) {
        jobList = value;
        if (mounted) setState(() {});
      }
    });
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

  var selectedISkills = [];
  void submit() {
    if (_formKey.currentState!.validate()) {
      final service = MemberRepo();
      DialogHelp.showLoading(context);

      service
          .submitJobProvider(
              mobile.text,
              name.text,
              memberno.text,
              designation.text,
              selectedISkills,
              formatId,
              experience.text,
              projectRequirement.text,
              notes.text,
              protfolioLink.text,
              available_start_date.text,
              available_end_date.text)
          .then((value) {
        DialogHelp().hideLoading(context);
        if (value.isNotEmpty) {
          Fluttertoast.showToast(
              msg: "Job Provider Added",
              backgroundColor: Colors.green,
              gravity: ToastGravity.TOP,
              textColor: Colors.white);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      JobProviders(),)
            );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   backgroundColor: AppTheme.whiteBackgroundColor,
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 1,
        title: const Text("Job Provider"),
        actions: [
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => JobProviders()));
              },
              child: Container(
                margin: EdgeInsets.only(right: 10),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
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
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Requirement Details",
                    style: Theme.of(context).textTheme.displayMedium!),
                SizedBox(
                  height: 6.h,
                ),
                MyTextField(
                    textEditingController: memberno,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Member Number";
                      }
                      return null;
                    },
                    
                    textInputType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: _onChangeHandler,
                    hintText: "Member Number",
                    color: const Color(0xff585A60)),
                SizedBox(height: 8.h),
                MyTextField(
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
                SizedBox(height: 8.h),
                MyTextField(
                    textEditingController: designation,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Grade";
                      }
                      return null;
                    },
                    // ontap: () {
                    //   ModalSheet.showModal(context, category, "ans", (value) {
                    //     //  print(value);
                    //     //sss _controller.setMode(value);
                    //     setState(() {
                    //       designation.text = value;
                    //     });
                    //   }, (value) {}, designation.text);
                    // },
                    // icon: Icon(
                    //   Icons.arrow_drop_down,
                    //   color: Color(0xff585A60),
                    // ),
                    // readOnly: true,
                    hintText: "Enter Grade",
                    color: const Color(0xff585A60)),
                // SizedBox(height: 8.h),
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
                SizedBox(height: 8.h),
                MyTextField(
                    readOnly: true,
                    textEditingController: projectRequirement,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Select Project Requirement";
                      }
                      return null;
                    },
                    ontap: () {
                      ModalSheet.showModal(context, jobList[0], "post",
                          (value) {
                        setState(() {
                          projectRequirement.text = value;
                        });
                      }, (value) {
                        postAppyid = jobList[0][value]["id"].toString();
                        setState(() {});
                      }, projectRequirement.text);
                    },
                    hintText: "Select Project Requirement",
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Color(0xff585A60),
                    ),
                    color: const Color(0xff585A60)),

                SizedBox(height: 8.h),
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
                          formatId =
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
                SizedBox(height: 12.h),
                Text(
                  " Select Skills",
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(fontSize: 13),
                ),
                SizedBox(height: 5.h),
                if (skills.isNotEmpty)
                  ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      primary: false,
                      itemCount: skills[0].length,
                      itemBuilder: (_, int index) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            unselectedWidgetColor: Colors.white,
                          ),
                          child: CheckboxListTile(
                            contentPadding: EdgeInsets.all(0),
                            dense: true,
                            visualDensity:
                                const VisualDensity(horizontal: -4.0),
                            title: Text(
                              skills[0][index]["skill"].toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(fontSize: 14),
                            ),
                            value: selectedISkills
                                .contains(skills[0][index]["skill"].toString()),
                            onChanged: (_) {
                              if (selectedISkills.contains(
                                  skills[0][index]["skill"].toString())) {
                                selectedISkills.remove(skills[0][index]["skill"]
                                    .toString()); // unselect
                              } else {
                                selectedISkills.add(skills[0][index]["skill"]
                                    .toString()); // select
                              }
                              setState(() {});
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                        );
                      }),

                // MyTextField(
                //     textEditingController: experience,
                //     // validation: (value) {
                //     //   if (value == null || value.isEmpty) {
                //     //     return "Enter Experience";
                //     //   }
                //     //   return null;
                //     // },
                //     hintText: "Experience",
                //     color: const Color(0xff585A60)),
                SizedBox(height: 8.h),
                // MyTextField(
                //     textEditingController: projectRequirement,
                //     validation: (value) {
                //       if (value == null || value.isEmpty) {
                //         return "Enter Project Requirement";
                //       }
                //       return null;
                //     },
                //     hintText: "Project Requirement",
                //     color: const Color(0xff585A60)),
                // SizedBox(height: 8.h),
                // MyTextField(
                //     readOnly: true,
                //     textEditingController: availablesDates,
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
                //         availablesDates.text =
                //             formattedDate; //set output date to TextField value.
                //         setState(() {});
                //       } else {
                //         print("end from date is not selected");
                //       }
                //     },
                //     // textEditingController: _controller.emailController,
                //     validation: (value) {
                //       if (value == null || value.isEmpty) {
                //         return "Enter Availables Dates";
                //       }
                //       return null;
                //     },
                //     icon: Icon(
                //       Icons.calendar_month,
                //       color: Color(0xff585A60),
                //       size: 18,
                //     ),
                //     hintText: "Availables Dates",
                //     color: const Color(0xff585A60)),
                MyTextField(
                    readOnly: true,
                    textEditingController: available_start_date,
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
                        available_start_date.text =
                            formattedDate; //set output date to TextField value.
                        setState(() {});
                      } else {
                        print("end from date is not selected");
                      }
                    },
                    // textEditingController: _controller.emailController,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Required From";
                      }
                      return null;
                    },
                    icon: Icon(
                      Icons.calendar_month,
                      color: Color(0xff585A60),
                      size: 18,
                    ),
                    hintText: "Enter Required From",
                    color: const Color(0xff585A60)),
                SizedBox(height: 8.h),

                MyTextField(
                    readOnly: true,
                    textEditingController: available_end_date,
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
                        available_end_date.text =
                            formattedDate; //set output date to TextField value.
                        setState(() {});
                      } else {
                        print("end from date is not selected");
                      }
                    },
                    // textEditingController: _controller.emailController,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Required Till";
                      }
                      return null;
                    },
                    icon: Icon(
                      Icons.calendar_month,
                      color: Color(0xff585A60),
                      size: 18,
                    ),
                    hintText: "Enter Required Till",
                    color: const Color(0xff585A60)),
                SizedBox(height: 8.h),

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
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: RoundedButton(
                      ontap: () {
                        if (selectedISkills.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Select Skills",
                              backgroundColor: Colors.red,
                              gravity: ToastGravity.TOP,
                              textColor: Colors.white);
                          return;
                        }
                        submit();
                      },
                      title: "Apply",
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
