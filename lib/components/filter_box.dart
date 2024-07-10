import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/theme.dart';

class FilterBox extends StatelessWidget {
  FilterBox({
    super.key,
    required int selectIndex,
    required String category,
    required this.context,
    required this.index,
  })  : _selectIndex = selectIndex,
        _category = category;

  final int _selectIndex;
  String _category;
  final int index;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: index == 0 ? 0 : 12.w),
        decoration: BoxDecoration(
          color: _selectIndex == index
              ? Theme.of(context).primaryColor
              : AppTheme.whiteBackgroundColor,
          borderRadius: BorderRadius.circular(5),
          border: _selectIndex == index
              ? Border.all(width: 1.0, color: Theme.of(context).primaryColor)
              : Border.all(width: 1.0, color: Colors.grey.withOpacity(0.5)),
        ),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
            child: Text(_category,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    fontSize: 14,
                    color: AppTheme.darkTextColor,
                    height: 0))));
  }
}
