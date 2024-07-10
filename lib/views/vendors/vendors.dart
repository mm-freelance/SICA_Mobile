import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:sica/services/vendorsrepo.dart';
import 'package:sica/views/members/components/members_tabbar.dart';
import 'package:sica/views/vendors/vendors_details.dart';

import '../../theme/theme.dart';

class Vendors extends StatefulWidget {
  const Vendors({super.key});

  @override
  State<Vendors> createState() => _nameState();
}

class _nameState extends State<Vendors> {
  @override
  void initState() {
    super.initState();
    getVendirs();
  }

  String? accountType;
  void getVendirs() async {
    final service = VendorRepo();
    service.getvendors("").then((value) {
      if (value.isNotEmpty) {
        vendorList = value[0];
        if (mounted) setState(() {});
      }
    });
  }

  List vendorList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 0.1,
          title: Text("Service Provider"),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: AppTheme.bodyTextColor,
                ))
          ],
        ),
        //    body: Center(
        //   child: Container(
        //     width: 260.w,
        //     child: Lottie.network(
        //       'https://lottie.host/86c8b48e-69f0-48a6-a6c6-b506bb45a9d0/ERZSLsvt2n.json',

        //     ),
        //   ),
        // ),
        body: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            if (vendorList.isNotEmpty)
              Expanded(
                  child: ListView.builder(
                itemCount: vendorList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) =>
                      //         VendorsDetails(cat: vendorList[index]["category_id"])));
                    },
                    child: VendorCard(
                      vendor: vendorList[index],
                    ),
                  );
                },
              ))
            else
              Center(
                child: CircularProgressIndicator(),
              )
          ],
       )
       );
      //  body: Center(
      //   child: Container(
      //     width: 260.w,
      //     child: Lottie.network(
      //       'https://lottie.host/86c8b48e-69f0-48a6-a6c6-b506bb45a9d0/ERZSLsvt2n.json',
            
      //     ),
      //   ),
      // ));
  }
}

class VendorCard extends StatelessWidget {
  VendorCard({super.key, required this.vendor});
  var vendor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(vendor["category_name"],
                style: Theme.of(context).textTheme.headlineMedium!,
                maxLines: 2,
                
                overflow: TextOverflow.ellipsis),
            SizedBox(
              height: 6.w,
            ),
            Text(vendor["description"].toString(),
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontSize: 12, color: Theme.of(context).iconTheme.color)),
          ],
        ),
      ),
    );
  }
}
