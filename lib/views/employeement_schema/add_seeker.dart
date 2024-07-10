import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sica/models/OtherMemberProfile.dart';
import 'package:sica/services/member_repo.dart';
import 'package:sica/utils/config.dart';
import 'package:sica/views/employeement_schema/job_seeker.dart';
import 'package:sica/views/home/dashboard.dart';
import '../../components/buton.dart';
import '../../components/dynamic_modal_sheet.dart';
import '../../components/input_feild.dart';
import '../../models/JobSeekeModel.dart';
import '../../theme/theme.dart';

class AddJobSeeker extends StatefulWidget {
  const AddJobSeeker({super.key, required this.seeker});
  final MemberJobSeeker seeker;
  @override
  State<AddJobSeeker> createState() => _nameState();
}

class _nameState extends State<AddJobSeeker> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final mobile = TextEditingController();
  final name = TextEditingController();
  final memberno = TextEditingController();
  final designation = TextEditingController();
  // final skills = TextEditingController();
  // final skills2 = TextEditingController();
  final experience = TextEditingController();
  final portfiliolink = TextEditingController();
  final portfiliolink2 = TextEditingController();
  final startfrom = TextEditingController();
  final endto = TextEditingController();
  final postApply = TextEditingController();
  final notes = TextEditingController();
  var selectedISkills = [];
  String formatId = "";
  String jobSeekerId = "";
  String postAppyid = "";
  final medium = TextEditingController();
  // List postTypes = [
  //   {"type": "Operative Cameraman"},
  //   {"type": "Associate  Cameraman"},
  //   {"type": "Assistant Cameraman"},
  //   {"type": "1st Unit  Cameraman"},
  //   {"type": "2nd Unit Cameraman"},
  //   {"type": "1st Unit  Cameraman"},
  //   {"type": "Director of photography"}
  // ];
  // List category = [
  //   {"ans": "Life"},
  //   {"ans": "Active"},
  //   {"ans": "Junior"},
  //   {"ans": "Associate"}
  // ];
  String pdfFile = "";
  void uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc'],
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      // file = result.files.first;
      setState(() {
        pdfFile = file.path.toString();
      });
      print(file.name);
    } else {
      return;
    }
  }

  List<MemberBasicDetails>? memberBasicDetails;
  List<MemberBasicDetails>? memberBasicDetails2;
  @override
  void initState() {
    super.initState();
    if (widget.seeker.jobSeekerId != null) {
      memberno.text = widget.seeker.membershipNo.toString();
      jobSeekerId = widget.seeker.jobSeekerId.toString();
      name.text = widget.seeker.memberName.toString();

      designation.text = widget.seeker.grade.toString();
      postApply.text = widget.seeker.postApplyingId.toString();
      formatId = widget.seeker.mediumid.toString();
      medium.text = widget.seeker.mediumId.toString();
      startfrom.text = widget.seeker.startDate.toString();
      endto.text = widget.seeker.tillDate.toString();
      portfiliolink.text = widget.seeker.portifolioLink.toString();
      portfiliolink2.text = widget.seeker.portifolioLink2.toString();
      notes.text = widget.seeker.note.toString();
      for (var i = 0; i < widget.seeker.skillIds!.length; i++) {
        selectedISkills.add(widget.seeker.skillIds![i].name.toString()); // sele
      }
    }
    getMemberAllData();
    getSkills();
    getJobList();
    getMedium();
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

  void submit() {
    if (_formKey.currentState!.validate()) {
      String img64 = "";
      if (pdfFile != "") {
        final bytes = io.File(pdfFile).readAsBytesSync();

        img64 = base64Encode(bytes);
      }
      final service = MemberRepo();
      DialogHelp.showLoading(context);

      service
          .submitJobSeeker(
              mobile.text,
              name.text,
              memberno.text,
              designation.text,
              postApply.text,
              startfrom.text,
              endto.text,
              experience.text,
              portfiliolink.text,
              notes.text,
              formatId,
              selectedISkills,
              portfiliolink2.text,
              jobSeekerId,
              img64)
          .then((value) {
        DialogHelp().hideLoading(context);
        if (value.isNotEmpty) {
          if (jobSeekerId == "") {
            Fluttertoast.showToast(
                msg: "Job Seeker Added",
                backgroundColor: Colors.green,
                gravity: ToastGravity.TOP,
                textColor: Colors.white);
          } else {
            Fluttertoast.showToast(
                msg: "Job Seeker Updates",
                backgroundColor: Colors.green,
                gravity: ToastGravity.TOP,
                textColor: Colors.white);
          }
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => JobSeeker()));
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
        //  backgroundColor: AppTheme.backGround2,
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 1,
          centerTitle: false,
          title: const Text("Job Seeker"),
          actions: [
           if(jobSeekerId=="")
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => JobSeeker()));
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
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Member Number",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13),
                  ),
                  SizedBox(height: 2.h),
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
                  Text(
                    "Mobile Number",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13),
                  ),
                  SizedBox(height: 2.h),
                  MyTextField(
                      textEditingController: mobile,
                      readOnly: widget.seeker.jobSeekerId != null,
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
                    "Member Name",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13),
                  ),
                  SizedBox(height: 2.h),
                  MyTextField(
                      textEditingController: name,
                      readOnly: widget.seeker.jobSeekerId != null,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Name";
                        }
                        return null;
                      },
                      hintText: "Member Name",
                      color: const Color(0xff585A60)),
                  SizedBox(height: 8.h),
                  Text(
                    "Grade",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13),
                  ),
                  SizedBox(height: 2.h),
                  MyTextField(
                      textEditingController: designation,
                      readOnly: widget.seeker.jobSeekerId != null,
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
                  SizedBox(height: 8.h),
                  Text(
                    "Post Applying",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13),
                  ),
                  SizedBox(height: 2.h),
                  if (jobList.isNotEmpty)
                    MyTextField(
                        readOnly: true,
                        textEditingController: postApply,
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Post Applying";
                          }
                          return null;
                        },
                        ontap: () {
                          if (widget.seeker.jobSeekerId != null) {
                            return;
                          }
                          ModalSheet.showModal(context, jobList[0], "post",
                              (value) {
                            setState(() {
                              postApply.text = value;
                            });
                          }, (value) {
                            postAppyid = jobList[0][value]["id"].toString();
                            setState(() {});
                          }, postApply.text);
                        },
                        hintText: "Select Post Applying",
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Color(0xff585A60),
                        ),
                        color: const Color(0xff585A60)),
                  SizedBox(height: 8.h),
                  Text(
                    "Format",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13),
                  ),
                  SizedBox(height: 2.h),
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
                          if (widget.seeker.jobSeekerId != null) {
                            return;
                          }
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
                  SizedBox(height: 8.h),
                  // Text(
                  //   "Skills 1",
                  //   style: Theme.of(context)
                  //       .textTheme
                  //       .labelSmall!
                  //       .copyWith(fontSize: 13),
                  // ),
                  // SizedBox(height: 2.h),
                  // MyTextField(
                  //     textEditingController: skills,
                  //     // validation: (value) {
                  //     //   if (value == null || value.isEmpty) {
                  //     //     return "Enter Skills 1";
                  //     //   }
                  //     //   return null;
                  //     // },
                  //     hintText: "Skill 1",
                  //     color: const Color(0xff585A60)),
                  // SizedBox(height: 8.h),
                  Text(
                    " Select Skills",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13),
                  ),
                  SizedBox(height: 8.h),
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
                              value: selectedISkills.contains(
                                  skills[0][index]["skill"].toString()),
                              onChanged: (_) {
                                if (widget.seeker.jobSeekerId != null) {
                                  return;
                                }
                                if (selectedISkills.contains(
                                    skills[0][index]["skill"].toString())) {
                                  selectedISkills.remove(skills[0][index]
                                          ["skill"]
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
                  //     textEditingController: skills2,
                  //     hintText: "Skill 2",
                  //     color: const Color(0xff585A60)),
                  SizedBox(height: 12.h),
                  Text(
                    "Available from",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13),
                  ),
                  SizedBox(height: 2.h),
                  MyTextField(
                      readOnly: true,
                      textEditingController: startfrom,
                      ontap: () async {
                        if (widget.seeker.jobSeekerId != null) {
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
                          startfrom.text =
                              formattedDate; //set output date to TextField value.
                          setState(() {});
                        } else {
                          print("end from date is not selected");
                        }
                      },
                      // textEditingController: _controller.emailController,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Available from";
                        }
                        return null;
                      },
                      icon: Icon(
                        Icons.calendar_month,
                        color: Color(0xff585A60),
                        size: 18,
                      ),
                      hintText: "Enter Available from",
                      color: const Color(0xff585A60)),
                  SizedBox(height: 8.h),
                  Text(
                    "Available till",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13),
                  ),
                  SizedBox(height: 2.h),
                  MyTextField(
                      readOnly: true,
                      textEditingController: endto,
                      ontap: () async {
                        if (widget.seeker.jobSeekerId != null) {
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
                          endto.text =
                              formattedDate; //set output date to TextField value.
                          setState(() {});
                        } else {
                          print("end from date is not selected");
                        }
                      },
                      // textEditingController: _controller.emailController,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Available till";
                        }
                        return null;
                      },
                      icon: Icon(
                        Icons.calendar_month,
                        color: Color(0xff585A60),
                        size: 18,
                      ),
                      hintText: "Enter Available till",
                      color: const Color(0xff585A60)),
                  SizedBox(height: 8.h),
                  // Text(
                  //   "Experience",
                  //   style: Theme.of(context)
                  //       .textTheme
                  //       .labelSmall!
                  //       .copyWith(fontSize: 13),
                  // ),
                  // SizedBox(height: 2.h),
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
                  // SizedBox(height: 8.h),
                  Text(
                    "Portfolio Link 1",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13),
                  ),
                  SizedBox(height: 2.h),
                  MyTextField(
                      readOnly: widget.seeker.jobSeekerId != null,
                      textEditingController: portfiliolink,
                      // validation: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return "Enter Portfolio Link";
                      //   }
                      //   return null;
                      // },
                      hintText: "Portfolio Link 1",
                      color: const Color(0xff585A60)),
                  SizedBox(height: 8.h),
                  Text(
                    "Portfolio Link 2",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13),
                  ),
                  SizedBox(height: 2.h),
                  MyTextField(
                      textEditingController: portfiliolink2,
                      readOnly: widget.seeker.jobSeekerId != null,
                      // validation: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return "Enter Portfolio Link";
                      //   }
                      //   return null;
                      // },
                      hintText: "Portfolio Link 2",
                      color: const Color(0xff585A60)),
                  SizedBox(height: 8.h),
                  Text(
                    "Notes",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13),
                  ),
                  SizedBox(height: 2.h),
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
                  SizedBox(height: 10.h),
                  Text(
                    "Document",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 13),
                  ),
                  SizedBox(height: 8.h),
                  GestureDetector(
                    onTap: () {
                      if (widget.seeker.jobSeekerId != null) {
                        return;
                      }
                      uploadFile();
                    },
                    child: AspectRatio(
                      aspectRatio: 16 / 4,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: AppTheme.hintTextColor,
                              style: BorderStyle.solid,
                            ),
                            color: Color.fromARGB(255, 27, 26, 26),
                            borderRadius: BorderRadius.circular(12)),
                        child: pdfFile == ""
                            ? Text(
                                "Upload Attachments",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(color: AppTheme.hintTextColor),
                              )
                            : Text(
                                pdfFile,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(color: AppTheme.hintTextColor),
                              ),
                      ),
                    ),
                  ),
                  if (jobSeekerId == "")
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
        ));
  }
}
