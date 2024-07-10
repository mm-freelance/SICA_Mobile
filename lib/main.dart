import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sica/theme/theme.dart';
import 'package:sica/views/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Future.delayed(const Duration(milliseconds: 300));
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 800), 
        minTextAdapt: true,  
 
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: 'SICA',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.darkTheme,
            
            home: const SplashScreen(),
          );
        });
  }
}
