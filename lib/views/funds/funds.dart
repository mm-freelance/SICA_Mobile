import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sica/theme/theme.dart';
import '../../components/filter_box.dart';
import 'package:lottie/lottie.dart';

class Funds extends StatefulWidget {
  const Funds({Key? key}) : super(key: key);

  @override
  State<Funds> createState() => _FundsScreenState();
}

class _FundsScreenState extends State<Funds> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 1,
        title: const Text("Funds"),
      ),
      body: Center(
        child: Container(
          width: 260.w,
          child: Lottie.network(
            'https://lottie.host/86c8b48e-69f0-48a6-a6c6-b506bb45a9d0/ERZSLsvt2n.json',
            
          ),
        ),
      ),
    );
  }
}
