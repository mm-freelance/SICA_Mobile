import 'package:flutter/material.dart';

class paymentSuccess extends StatefulWidget {
  const paymentSuccess({super.key});

  @override
  State<paymentSuccess> createState() => _nameState();
}

class _nameState extends State<paymentSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Payment Success"),),);
  }
}