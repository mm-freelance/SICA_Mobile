import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/theme.dart';

class FullScreenImage extends StatefulWidget {
  const FullScreenImage({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  State<FullScreenImage> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  SystemUiOverlayStyle getSystemUIOverlayStyle(BuildContext context) {
    final theme = Theme.of(context);
    return SystemUiOverlayStyle(
      //  systemNavigationBarColor: theme.colorScheme.surface,
      ///   systemNavigationBarDividerColor: theme.colorScheme.surface,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarDividerColor: Color.fromARGB(255, 1, 1, 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    // return AnnotatedRegion<SystemUiOverlayStyle>(
    //   value: getSystemUIOverlayStyle(context),
    return Scaffold(
      backgroundColor: AppTheme.blackColor,
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.5),
        titleSpacing: 0,
        //    automaticallyImplyLeading: false,

        title: Text(
          "Image",
          style: TextStyle(color: AppTheme.whiteBackgroundColor),
        ),
      ),

      //   backgroundColor: Colors.transparent,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: InteractiveViewer(
            panEnabled: false, // Set it to false to prevent panning.
            // boundaryMargin: const EdgeInsets.all(20.0),
            minScale: 0.1,
            maxScale: 3,
            child: Image.network(
              widget.url.toString(),
              fit: BoxFit.contain,
            )),
      ),
    );
  }
}
