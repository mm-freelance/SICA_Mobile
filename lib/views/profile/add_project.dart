import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sica/components/buton.dart';
import 'package:sica/components/input_feild.dart';
import 'package:sica/models/MemberDetailModel.dart';
import 'package:sica/services/member_repo.dart';
import 'package:sica/theme/theme.dart';
import 'package:sica/utils/config.dart';
import 'package:sica/views/home/dashboard.dart';

class AddProject extends StatefulWidget {
  const AddProject({super.key, required this.projectList});
  final ProjectWork projectList;

  @override
  State<AddProject> createState() => _nameState();
}

class _nameState extends State<AddProject> {
  String showYear = 'Select Year';
  DateTime _selectedYear = DateTime.now();
  final name = TextEditingController();
  final year = TextEditingController();
  final designation = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.projectList.id != null) {
      name.text = widget.projectList.projectName.toString();
     year.text = widget.projectList.year.toString();
     _selectedYear = DateTime(int.parse(widget.projectList.year.toString()));
      designation.text = widget.projectList.designation.toString();
    }
    setState(() {});
  }

  selectYear(context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.cardDarkColor,
          //co
          title: Text(
            "Select Year",
            style: TextStyle(color: AppTheme.whiteBackgroundColor),
          ),
          content: SizedBox(
            width: 300.w,
            height: 300.h,
            child: YearPicker(
              firstDate: DateTime(DateTime.now().year - 50, 1),
              lastDate: DateTime(DateTime.now().year + 10, 1),
              initialDate: DateTime.now(),
              selectedDate: _selectedYear,
              onChanged: (DateTime dateTime) {
                print(dateTime.year);
                setState(() {
                  _selectedYear = dateTime;
                  year.text = dateTime.year.toString();
                  showYear = "${dateTime.year}";
                  print(showYear);
                  setState(() {});
                });
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }

  void submit() {
    if (formKey.currentState!.validate()) {
      final service = MemberRepo();
      DialogHelp.showLoading(context);
      service.addWork(name.text, year.text, designation.text).then((value) {
        DialogHelp().hideLoading(context);
        if (value.isNotEmpty) {
          Fluttertoast.showToast(
              msg: "Work Added Successfully",
              backgroundColor: Colors.green,
              gravity: ToastGravity.TOP,
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

  void editWork() {
    if (formKey.currentState!.validate()) {
      final service = MemberRepo();
      DialogHelp.showLoading(context);
      service
          .editWork(name.text, year.text, designation.text,
              int.parse(widget.projectList.id.toString()))
          .then((value) {
        DialogHelp().hideLoading(context);
        if (value.isNotEmpty) {
          Fluttertoast.showToast(
              msg: "Work Edit Successfully",
              backgroundColor: Colors.green,
              gravity: ToastGravity.TOP,
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
void deleteWork() {
    if (formKey.currentState!.validate()) {
      final service = MemberRepo();
      DialogHelp.showLoading(context);
      service
          .deleteWork(name.text, year.text, designation.text,
              int.parse(widget.projectList.id.toString()))
          .then((value) {
        DialogHelp().hideLoading(context);
        if (value.isNotEmpty) {
          Fluttertoast.showToast(
              msg: "Work Delete Successfully",
              backgroundColor: Colors.green,
              gravity: ToastGravity.TOP,
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
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        titleSpacing: 0,
        elevation: 0,
        title: Text(
            widget.projectList.id != null ? "Edit Project" : "Add Project"),
        actions: [
          if( widget.projectList.id != null)
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: IconButton(
              icon: Icon(Icons.delete, color: Colors.red,),
              onPressed: () {deleteWork();},
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 8.h),
              MyTextField(
                  textEditingController: name,
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Project name";
                    }
                    return null;
                  },
                  hintText: "Project name",
                  float: FloatingLabelBehavior.always,
                  labelText: "",
                  color: const Color(0xff585A60)),
              SizedBox(height: 8.h),
              MyTextField(
                  textEditingController: year,
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return "Year is required";
                    }
                    return null;
                  },
                  ontap: () {
                    selectYear(context);
                  },
                  icon: Icon(
                    Icons.calendar_month,
                    color: AppTheme.primaryColor,
                  ),
                  readOnly: true,
                  hintText: "Select Year",
                  float: FloatingLabelBehavior.always,
                  labelText: "",
                  color: const Color(0xff585A60)),
              SizedBox(height: 8.h),
              MyTextField(
                  textEditingController: designation,
                  float: FloatingLabelBehavior.always,
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return "Designation is required";
                    }
                    return null;
                  },
                  hintText: "Select Designation",
                  labelText: "",
                  color: const Color(0xff585A60)),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.h),
                child: RoundedButton(
                    ontap: () {
                      if (widget.projectList.id != null) {
                        editWork();
                      } else {
                        submit();
                      }
                    },
                    title: "Save",
                    color: Theme.of(context).primaryColor,
                    textcolor: AppTheme.darkTextColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
