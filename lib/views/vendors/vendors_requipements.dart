import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sica/views/members/components/members_tabbar.dart';
import 'package:sica/views/vendors/vendors_details.dart';
import '../../services/vendorsrepo.dart';
import '../../theme/theme.dart';
import 'components/vendor_cards.dart';

class VendorsList extends StatefulWidget {
const VendorsList({super.key, required this.cat});
  final int cat;
  @override
  State<VendorsList> createState() => _nameState();
}

class _nameState extends State<VendorsList> {
   @override
  void initState() {
    super.initState();
    getProducts();
  }

  
  void getProducts() async {
    final service = VendorRepo();
    service.getProducts(widget.cat).then((value) {
      if (value.isNotEmpty) {
        productList = value[0];
        if (mounted) setState(() {});
      }
    });
  }

  List productList = [];
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
            if (productList.isNotEmpty)
              Expanded(
                  child: ListView.builder(
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    vendor: productList[index],
                  );
                },
              ))
            else
              Center(
                child: CircularProgressIndicator(),
              )
          ],
        ));
  }
}

class ProductCard extends StatelessWidget {
  ProductCard({super.key, required this.vendor});
  var vendor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(vendor["product_name"],
                style: Theme.of(context).textTheme.headlineMedium!,
                maxLines: 2,
                
                overflow: TextOverflow.ellipsis),
            SizedBox(
              height: 4.w,
            ),
            Text(vendor["description"].toString(),
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

