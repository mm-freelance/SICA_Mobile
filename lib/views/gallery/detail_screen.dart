import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/GalleryModel.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.data}) : super(key: key);
  final GalleryDetails data;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 0,
          title: Text(widget.data.name.toString()),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              widget.data.imageUrl.toString(),
              alignment: Alignment.center,
              //  height: double.infinity,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 25, right: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Row(
                    //   children: [
                    //     GestureDetector(
                    //       onTap: () {},
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(6.0),
                    //         child: Container(
                    //           height: 30,
                    //           alignment: Alignment.center,
                    //           width: 30,
                    //           child: Icon(Icons.thumb_up_alt,
                    //               size: 20,
                    //               color: AppTheme.whiteBackgroundColor),
                    //         ),
                    //       ),
                    //     ),
                    //     Text("2"),
                    //     const SizedBox(
                    //       width: 30,
                    //     ),
                    //     GestureDetector(
                    //       onTap: () {},
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(6.0),
                    //         child: Container(
                    //           height: 30,
                    //           alignment: Alignment.center,
                    //           width: 30,
                    //           child: Icon(Icons.comment_outlined,
                    //               size: 20,
                    //               color: AppTheme.whiteBackgroundColor),
                    //         ),
                    //       ),
                    //     ),
                    //     Text("1"),
                    //   ],
                    // ),
                    const SizedBox(
                      height: 6,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                          left: 1,
                          top: 2,
                          bottom: 8,
                        ),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            minHeight: 25.0,
                            maxHeight: 100.0,
                          ),
                          child: SingleChildScrollView(
                            child: Text(
                              widget.data.description.toString(),
                              style: GoogleFonts.montserrat(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ),
            // Align(
            //   alignment: Alignment.bottomRight,
            //   child: Container(
            //     margin: EdgeInsets.only(bottom: 30),
            //     // height: 480,
            //     //color: AppColors.grayColor1,
            //     child: Padding(
            //       padding: EdgeInsets.only(
            //         right: 12.w,
            //       ),
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.end,
            //         children: [
            //           GestureDetector(
            //             onTap: () {},
            //             child: Container(
            //               decoration: BoxDecoration(
            //                   border: Border.all(
            //                       color: AppTheme.whiteBackgroundColor),
            //                   shape: BoxShape.circle),
            //               child: Padding(
            //                 padding: const EdgeInsets.all(6.0),
            //                 child: Container(
            //                   height: 30,
            //                   alignment: Alignment.center,
            //                   width: 30,
            //                   child: Icon(Icons.thumb_up_alt,
            //                       size: 20,
            //                       color: AppTheme.whiteBackgroundColor),
            //                 ),
            //               ),
            //             ),
            //           ),
            //           const SizedBox(
            //             height: 30,
            //           ),
            //           GestureDetector(
            //             onTap: () {},
            //             child: Container(
            //               decoration: BoxDecoration(
            //                   border: Border.all(
            //                       color: AppTheme.whiteBackgroundColor),
            //                   shape: BoxShape.circle),
            //               child: Padding(
            //                 padding: const EdgeInsets.all(6.0),
            //                 child: Container(
            //                   height: 30,
            //                   alignment: Alignment.center,
            //                   width: 30,
            //                   child: Icon(Icons.comment_outlined,
            //                       size: 20,
            //                       color: AppTheme.whiteBackgroundColor),
            //                 ),
            //               ),
            //             ),
            //           ),
            //           const SizedBox(
            //             height: 100,
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ));
  }
   

  
}
