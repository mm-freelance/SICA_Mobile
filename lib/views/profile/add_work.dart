import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sica/views/shooting/create_dop.dart';

import '../../components/buton.dart';
import '../../components/dynamic_modal_sheet.dart';
import '../../components/input_feild.dart';
import '../../models/OtherMemberProfile.dart';
import '../../theme/theme.dart';

class WorkModel {
  String name;
  String mobile;
  int id;
  String memberno;

  WorkModel({
    this.name = "",
    this.memberno = "",
    this.mobile = "",
    required this.id,
  });
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'memberno': memberno,
      'mobile': mobile,
    };
  }
}

class AddWork extends StatefulWidget {
  AddWork({super.key});

  @override
  State<AddWork> createState() => _AddWorkState();
}

class _AddWorkState extends State<AddWork> {
  List<WorkForm> workForm = List.empty(growable: true);
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    WorkModel _workModel = WorkModel(id: 1);
    workForm.add(WorkForm(
      index: workForm.length,
      workModel: _workModel,
      onRemove: () => onRemove(_workModel),
    ));
  }

  onRemove(WorkModel work) {
    setState(() {
      int index =
          workForm.indexWhere((element) => element.workModel.id == work.id);

      if (workForm != null) workForm.removeAt(index);
    });
  }

  onAdd() {
    setState(() {
      WorkModel _workModel = WorkModel(id: workForm.length);
      workForm.add(WorkForm(
        index: workForm.length,
        workModel: _workModel,
        onRemove: () => onRemove(_workModel),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 1,
        title: Text("Add Member"),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         onAdd();
        //       },
        //       icon: Icon(
        //         Icons.add,
        //         //  color: AppTheme.bodyTextColor,
        //       ))
        // ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: 5.h),
                if (workForm.isNotEmpty)
                  ListView.builder(
                      primary: false,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: workForm.length,
                      itemBuilder: (_, index) {
                        return workForm[index];
                      })
                else
                  Center(child: Text("Tap on + to Add Member")),
                  RoundedButton(
                ontap: () {
                     onAdd();
                  },
                 height: 44,
                      title: "Add Member ",
                      color: Theme.of(context).primaryColor,
                      textcolor: AppTheme.darkTextColor),
                
                SizedBox(height: 20.h),
                if (workForm.isNotEmpty)
                  RoundedButton(
                      ontap: () {
                        if (formKey.currentState!.validate()) {
                          List<WorkModel> worklist = [];
                          Map<String, dynamic> json = {};
                          final List<Map<String, dynamic>> _dataArray = [];
                          for (int i = 0; i < workForm.length; i++) {
                            Map<String, dynamic> json = {
                              'name': '${workForm[i].name.text.toString()}',
                              'mobile_number':
                                  '${workForm[i].mobile.text.toString()}',
                              'member_number':
                                  '${workForm[i].memberno.text.toString()}',
                              'role': '${workForm[i].roleType.text.toString()}',
                            };
                            _dataArray.add(json);
                            worklist.add(WorkModel(
                                name: workForm[i].name.text.toString(),
                                memberno: workForm[i].memberno.text.toString(),
                                mobile: workForm[i].mobile.text.toString(),
                                id: workForm[i].index));
                          }
                          Navigator.pop(context, _dataArray);
                          //  Navigator.of(context).push(MaterialPageRoute(
                          // builder: (context) =>  CreateDOP(associate: _dataArray,)));
                        }
                      },
                      height: 44,
                      title: "Save",
                      color: Theme.of(context).primaryColor,
                      textcolor: AppTheme.darkTextColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WorkForm extends StatefulWidget {
  WorkForm({
    super.key,
    this.index,
    required this.onRemove,
    required this.workModel,
  });
  final index;
  WorkModel workModel;
  final Function onRemove;
  final mobile = TextEditingController();
  final name = TextEditingController();
  final memberno = TextEditingController();
  final roleType = TextEditingController();
  // List roleTypes = [
  //   {"type": "Operative"},
  //   {"type": "Associate"},
  //   {"type": "Assistant"}
  // ];
  State<WorkForm> createState() => _WorkFormState();
}

class _WorkFormState extends State<WorkForm> {
  @override
  void initState() {
    super.initState();
    getMemberAllData();
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
        widget.mobile.text =
            memberBasicDetails2!.first.memberDetails!.mobileNumber!;
        widget.name.text = memberBasicDetails2!.first.memberDetails!.name!;
        widget.memberno.text =
            memberBasicDetails2!.first.memberDetails!.membershipNo!;
        widget.roleType.text =
            memberBasicDetails2!.first.memberDetails!.grade!;
      } else {
        widget.mobile.clear();
        widget.name.clear();
        widget.roleType.clear();
       
      }
    } else {
      widget.mobile.clear();
      widget.roleType.clear();
      widget.name.clear();
     
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Member ${widget.index + 1}",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: AppTheme.whiteBackgroundColor)),
            InkWell(
              onTap: () {
                widget.onRemove();
              },
              child: const Icon(
                Icons.delete,
                color: Color.fromARGB(255, 247, 74, 62),
              ),
            )
          ],
        ),
        SizedBox(height: 8.h),
        MyTextField(
            float: FloatingLabelBehavior.always,
            validation: (value) {
              if (value == null || value.isEmpty) {
                return "Member No. is required";
              }
              return null;
            },
            onChanged: _onChangeHandler,
            textEditingController: widget.memberno,
            hintText: "Enter Member No.",
            labelText: "",
            color: const Color(0xff585A60)),
        SizedBox(height: 8.h),
        MyTextField(
            textEditingController: widget.name,
            validation: (value) {
              if (value == null || value.isEmpty) {
                return "Name is required";
              }
              return null;
            },
            onChanged: (value) {},
            hintText: "Name",
            float: FloatingLabelBehavior.always,
            labelText: "",
            color: const Color(0xff585A60)),
        SizedBox(height: 8.h),
        MyTextField(
            textEditingController: widget.mobile,
            validation: (value) {
              if (value == null || value.isEmpty) {
                return "Mobile is required";
              }
              return null;
            },
            onChanged: (value) {},
            hintText: "Enter Mobile",
            float: FloatingLabelBehavior.always,
            labelText: "",
            color: const Color(0xff585A60)),
        SizedBox(height: 8.h),
        MyTextField(
            textEditingController: widget.roleType,
            validation: (value) {
              if (value == null || value.isEmpty) {
                return "Enter Grade";
              }
              return null;
            },
            hintText: "Enter Grade",
            color: const Color(0xff585A60)),
        SizedBox(height: 22.h),
      ],
    );
  }
}
