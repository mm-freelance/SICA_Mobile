import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/theme.dart';

class MyTextField extends StatelessWidget {
  String hintText;
  String labelText;
  var color;
  var fillcolor;
  var icon;
  var preicon;
  bool readOnly;
  var validation;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  var ontap;
  var ontapSuffix;
  FloatingLabelBehavior float;
  final ValueChanged<String>? onChanged;
  final bool obsecureText;
  final bool isSuffixIcon;
  final TextEditingController? textEditingController;
  MyTextField(
      {super.key,
      required this.hintText,
      required this.color,
      this.icon,
      this.onChanged,
      this.fillcolor = Colors.white,
      this.ontapSuffix,
      this.obsecureText = false,
      this.isSuffixIcon = false,
      this.readOnly = false,
      this.preicon,
      this.ontap,
      this.float = FloatingLabelBehavior.auto,
      this.labelText = "",
      this.textInputType,
      this.inputFormatters,
      this.textEditingController,
      this.validation});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 4, bottom: 8),
      child: TextFormField(
          keyboardType: textInputType,
          onTap: ontap,
          readOnly: readOnly,
          inputFormatters: inputFormatters,
          controller: textEditingController,
          obscureText: obsecureText,
          validator: validation,
          onChanged: onChanged,
          cursorColor: Theme.of(context).primaryColor,
          textAlignVertical: TextAlignVertical.center,
          style:
              TextStyle(fontSize: 14, color: AppTheme.whiteBackgroundColor),
          decoration: InputDecoration(
              floatingLabelBehavior: float,
              labelStyle: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(color: AppTheme.hintTextColor),
              counterText: '',
              errorStyle: GoogleFonts.roboto(fontSize: 12),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color.fromRGBO(225, 30, 61, 1),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.r),
              ),
              hintStyle: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(color: AppTheme.hintTextColor, fontSize: 13),
              fillColor: const Color(0xFF121212),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.hintTextColor),
                borderRadius: BorderRadius.circular(8.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:  BorderSide(color: AppTheme.hintTextColor),
                borderRadius: BorderRadius.circular(8.r),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.hintTextColor),
                borderRadius: BorderRadius.circular(8.r),
              ),
              filled: true,
              // fillColor: fillcolor,
              // labelText: labelText,
              // label: Text(labelText,style: Theme.of(context)
              //     .textTheme
              //     .displaySmall!
              //     .copyWith(color: AppTheme.hintTextColor),),
              isDense: true,
            
              contentPadding:
                  const EdgeInsetsDirectional.fromSTEB(10, 12, 12, 12),
              hintText: hintText,
              floatingLabelStyle: Theme.of(context).textTheme.displaySmall,
              suffixIcon: isSuffixIcon
                  ? GestureDetector(
                      onTap: ontapSuffix,
                      child: !obsecureText
                          ? Icon(
                              Icons.visibility_off,
                              size: 18.h,
                              color: Colors.grey,
                            )
                          : Icon(
                              Icons.visibility,
                              size: 18.h,
                              color: Colors.grey,
                            ),
                    )
                  : icon)),
    );
  }
}
