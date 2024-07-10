import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sica/views/members/components/members_tabbar.dart';
import 'package:sica/views/vendors/vendors_details.dart';
import '../../theme/theme.dart';
import 'components/operator_cards.dart';

class OperatorList extends StatefulWidget {
  const OperatorList({super.key, required this.vendorList});
final List vendorList;
  @override
  State<OperatorList> createState() => _nameState();
}

class _nameState extends State<OperatorList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //  backgroundColor: AppTheme.backGround2,
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 0,
          title:const Text("Equipments"),
          
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Expanded(
                child: ListView.builder(
              itemCount: widget.vendorList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => VendorsDetails(
                    //         vendors: widget.vendorList[index]["vendors"])));
                  },
                  child: Padding(
                   padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    child: OperatorCardDetails(
                      operator: widget.vendorList[index],
                    ),
                  ),
                );
              },
            ))
          ],
        ));
  }
}
