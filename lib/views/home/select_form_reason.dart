import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:sica/services/member_repo.dart';
import 'package:sica/views/home/shooting_diary_reason.dart';

import '../../components/buton.dart';
import '../../components/dynamic_modal_sheet.dart';
import '../../components/input_feild.dart';
import '../../theme/theme.dart';
import 'form.dart';

class SelectReason extends StatefulWidget {
  const SelectReason({super.key});

  @override
  State<SelectReason> createState() => _nameState();
}

class _nameState extends State<SelectReason> {
  final reasonText = TextEditingController();
  List reasons = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMedium();
  }

  String? reasonid;
  void getMedium() {
    final service = MemberRepo();
    service.getReasons().then((value) {
      if (value.isNotEmpty) {
        reasons = value;
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
        titleTextStyle: TextStyle(fontSize: 16),
        title: const Text("Grievances"),
      ),
      //  body: Center(
      //   child: Container(
      //     width: 260.w,
      //     child: Lottie.network(
      //       'https://lottie.host/86c8b48e-69f0-48a6-a6c6-b506bb45a9d0/ERZSLsvt2n.json',

      //     ),
      //   ),
      // ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 8.h, top: 20.h),
                child: Text(
                  "Select Reason",
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(fontSize: 13),
                ),
              ),
              if (reasons.isNotEmpty)
                MyTextField(
                    readOnly: true,
                    textEditingController: reasonText,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return "Grievances reason is required";
                      }
                      return null;
                    },
                    ontap: () {
                      ModalSheet.showModal(context, reasons[0], "reason_name",
                          (value) {
                        setState(() {
                          reasonText.text = value;
                        });
                      }, (value) {
                        reasonid = reasons[0][value]["reason_id"].toString();
                        setState(() {});
                      }, reasonText.text);
                    },
                    hintText: "Your answer",
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Color(0xff585A60),
                    ),
                    color: const Color(0xff585A60)),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 5),
                child: RoundedButton(
                    ontap: () {
                      if (_formKey.currentState!.validate()) {
                        if (reasonid == "3") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CreateShootingReport(reasonid: reasonid!),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CreateDelayReport(reasonid: reasonid!),
                            ),
                          );
                        }
                      }
                    },
                    title: "Continue",
                    height: 42,
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
