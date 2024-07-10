import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:sica/views/members/components/members_tabbar.dart';
import 'package:sica/views/vendors/vendors_details.dart';

import 'operator_details.dart';

class Operators extends StatefulWidget {
  const Operators({super.key});

  @override
  State<Operators> createState() => _nameState();
}

class _nameState extends State<Operators> {
  List vendorList = [
    {
      "title":"Camera",
      "image": "assets/images/camera.jpg",
      "vendors": [
        {
          "name": "KRAFTMAN STUDIO",
          "types": [
            {
              "name": "Sony fx9 / FX3",
            },
            {
              "name": "Canon 5D Mark IV",
            },
            {
              "name": "LENSES :- CP3, zeiss 70 - 200",
            }
          ]
        },
        {
          "name": "CINE ",
          "types": [
            {
              "name": "Arri 4 KW Par Light",
            },
            {
              "name": "Arri M18 /1.2 KW Light",
            },
            {
              "name": "Arri M40 4KW",
            }
          ]
        },
        {
         "name": "LAKSHMI BALAJI FILMS",      
          "types": [
            {
              "name": "Skimmer 12 x 12",
            },
            {
              "name": "Skimmer 8 x 8",
            },
            {
              "name": "Skimmer 10 x 10",
            }
          ]
        }
      ]
    },
    {
      "title":  "Lights",
      "image": "assets/images/camera.jpg",
      "vendors": [
        {
          "name":  "CINE",
          "types": [
            {
              "name": "Arri Max 18Kw DayLight Set",
            },
            {
              "name": "Arri Max 18Kw DayLight Set (Bulb 12Kw)",
            },
            {
              "name": "Arri Max M-90 DayLight Set",
            }
          ]
        },
        {
           "name": "KRAFTMAN STUDIO",
          "types": [
            {
              "name": "Litepanel Astra 1x1 BI-Color",
            },
            {
              "name": "Litepanel Mini Panel Kit 1.5ft",
            },
            {
              "name": "LED PANEL 1x2 Kit",
            }
          ]
        },
        {
          "name": "LAKSHMI BALAJI FILMS",
          "types": [
            {
              "name": "ARRI LoCaster 2 Plus LED AC Single Kit",
            },
            {
              "name": "ARRI L SERIES",
            },
            {
              "name": "ARRI L10-C",
            }
          ]
        }
      ]
    },
    {
      "title": "Grips",
      "image": "assets/images/camera.jpg",
      "vendors": [
        {
          "name": "LAKSHMI BALAJI FILMS",
          "types": [
            {
              "name": " ARRI ALEXA SXT_W",
            },
            {
              "name": "ARRI ALEXA MINI",
            },
            {
              "name": "ARRI ALEXA_XT ",
            }
          ]
        },
        {
          "name":  "CINE",
          "types": [
            {
              "name": "Arri M40 original",
            },
            {
              "name": "Arri 4Kv Par ",
            },
            {
              "name": "Arri 1.2 par",
            }
          ]
        },
        {
          "name": "KRAFTMAN STUDIO",
          "types": [
            {
              "name": "Bar Stand",
            },
            {
              "name": "Bar Stand Mini",
            },
            {
              "name": "C Stand",
            },
             {
              "name": "C Stand mini",
            }
          ]
        }
      ]
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //  backgroundColor: AppTheme.backGround2,
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 0,
          title: Text("Operators"),
          actions: [
            IconButton(
                onPressed: (){},
                icon: Icon(
                  Icons.search,
               //   color: AppTheme.bodyTextColor,
                ))
          ],
        ),
        body: Center(
        child: Container(
          width: 260.w,
          child: Lottie.network(
            'https://lottie.host/86c8b48e-69f0-48a6-a6c6-b506bb45a9d0/ERZSLsvt2n.json',
            
          ),
        ),
      ),
        // body: Column(
        //   children: [
        //     SizedBox(
        //       height: 10.h,
        //     ),
        //     Expanded(
        //         child: ListView.builder(
        //       itemCount: vendorList.length,
        //       itemBuilder: (context, index) {
        //         return GestureDetector(
        //           onTap: () {
        //             Navigator.of(context).push(MaterialPageRoute(
        //                 builder: (context) => OperatorDetails(
        //                     vendors: vendorList[index]["vendors"])));
        //           },
        //           child: VendorCard(
        //             vendor: vendorList[index],
        //           ),
        //         );
        //       },
        //     ))
        //   ],
       // )
        );
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
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 50.h,
              width: 50.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/camera.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Text(vendor["title"],
                    style: Theme.of(context).textTheme.headlineMedium!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 18.h,
                      color: Theme.of(context).primaryColor,
                    ),
                    Text(' 4.1',
                        style:
                            Theme.of(context).textTheme.displaySmall!.copyWith(
                                  fontSize: 14,
                                )),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(' (3.5k)',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontSize: 12,
                        color: Theme.of(context).iconTheme.color)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
