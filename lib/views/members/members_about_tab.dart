import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sica/views/profile/add_socialsLinks.dart';
import 'package:sica/views/profile/profile.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/MemberDetailModel.dart';
import '../../theme/theme.dart';

class MemberAboutTab extends StatefulWidget {
  const MemberAboutTab({super.key, required this.memberdetails});
  final MemberBasicDetails memberdetails;

  @override
  State<MemberAboutTab> createState() => _nameState();
}

class _nameState extends State<MemberAboutTab> {
  List socialLinks = [
    {"image": "imbd.png", "title": "IMDB"},
    {"image": "facebook.png", "title": "Facebook"},
    {"image": "insta.png", "title": "Insta"},
    {"image": "youtube.png", "title": "youtube"},
    {"image": "twiter.png", "title": "twiter"},
    {"image": "imbd.png", "title": "IMDB"}
  ];

  launchURLMethod(String link) async {
    final Uri url = Uri.parse(link);
    try {
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
      // ignore: empty_catches
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
      // decoration: BoxDecoration(
      //     color: Theme.of(context).cardColor,
      //     borderRadius: BorderRadius.circular(8),
      //     border: Border.all(color: Colors.grey.withOpacity(0.4), width: 1)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.memberdetails.image.toString() == "")
                  Container(
                    height: 150,
                    width: 120,
                    decoration: BoxDecoration(
                      //  shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/profile.jpeg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                else
                  Container(
                    height: 150,
                    width: 120,
                    decoration: BoxDecoration(
                      //  shape: BoxShape.circle,
                      image: DecorationImage(
                        image:
                            NetworkImage(widget.memberdetails.image.toString()),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.memberdetails.name.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  fontSize: 16,
                                )),
                        Divider(
                          color: AppTheme.backGround2,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        RichText(
                          textScaleFactor: 1,
                          text: TextSpan(
                            text: '#',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(fontSize: 18, height: 0),
                            children: <TextSpan>[
                              TextSpan(
                                  text:
                                      ' ${widget.memberdetails.membershipNo.toString()}',
                                  style: TextStyle(fontSize: 16, height: 0)),
                            ],
                          ),
                        ),
                        Divider(
                          color: AppTheme.backGround2,
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          widget.memberdetails.grade.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                fontSize: 16,
                              ),
                        ),
                        Divider(
                          color: AppTheme.backGround2,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (widget.memberdetails.contact_show.toString() != "false")
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Contact no.",
                        style: Theme.of(context).textTheme.headlineMedium!),
                    Text(
                      widget.memberdetails.mobileNumber.toString(),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            if (widget.memberdetails.contact_show.toString() != "false")
              Divider(
                color: AppTheme.backGround2,
              ),
               if (widget.memberdetails.state
                                  .toString() !=
                              "")
                            Padding(
                              padding: const EdgeInsets.only(top: 25, bottom: 2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Status",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!),
                                  GestureDetector(
                                    onTap: () {
                                    
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                          color:widget.memberdetails
                                            .state
                                            .toString()=="Live"? Colors.green:widget.memberdetails
                                            .state
                                            .toString()=="Debar"?Colors.orange:Colors.red,
                                          borderRadius: BorderRadius.circular(4)),
                                      child: Text(
                                        widget.memberdetails
                                            .state
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(fontSize: 22),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          Divider(
                            color: AppTheme.backGround2,
                          ),
            if (widget.memberdetails.email.toString() != "")
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Email",
                        style: Theme.of(context).textTheme.headlineMedium!),
                    Text(
                      "${widget.memberdetails.email.toString()}",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            if (widget.memberdetails.email.toString() != "")
              Divider(
                color: AppTheme.backGround2,
              ),
            if (widget.memberdetails.date_of_birth.toString() != "")
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("DOB",
                        style: Theme.of(context).textTheme.headlineMedium!),
                    Text(
                      "${widget.memberdetails.date_of_birth.toString()}",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            if (widget.memberdetails.date_of_birth.toString() != "")
              Divider(
                color: AppTheme.backGround2,
              ),
            if (widget.memberdetails.joiningDate.toString() != "")
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("DOJ",
                        style: Theme.of(context).textTheme.headlineMedium!),
                    Text(
                      "${widget.memberdetails.joiningDate.toString()}",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            if (widget.memberdetails.joiningDate.toString() != "")
              Divider(
                color: AppTheme.backGround2,
              ),
            if (widget.memberdetails.portifolioLink.toString() != "")
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Portfolio Link",
                        style: Theme.of(context).textTheme.headlineMedium!),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          launchURLMethod(
                              widget.memberdetails.portifolioLink.toString());
                        },
                        child: Text(
                          "${widget.memberdetails.portifolioLink.toString()}",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.blue),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (widget.memberdetails.portifolioLink.toString() != "")
              Divider(
                color: AppTheme.backGround2,
              ),
            if (widget.memberdetails.notes.toString() != "")
              if (widget.memberdetails.notes_show.toString() != "false")
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text("About",
                      style: Theme.of(context).textTheme.headlineMedium!),
                ),
            if (widget.memberdetails.notes.toString() != "")
              if (widget.memberdetails.notes_show.toString() != "false")
                Padding(
                  padding: const EdgeInsets.only(top: 6, bottom: 4),
                  child: Text(
                    "${widget.memberdetails.notes.toString()}",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
            if (widget.memberdetails.notes.toString() != "")
              if (widget.memberdetails.notes_show.toString() != "false")
                Divider(
                  color: AppTheme.backGround2,
                ),
            SizedBox(
              height: 22.h,
            ),
            if (widget.memberdetails.facebookLink.toString() != "" ||
                widget.memberdetails.imdb_link.toString() != "" ||
                widget.memberdetails.linkedinLink.toString() != "" ||
                widget.memberdetails.twitterLink.toString() != "" ||
                widget.memberdetails.instagramLink.toString() != "" ||
                widget.memberdetails.youtubeLink.toString() != "")
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Socials Link",
                      style: Theme.of(context).textTheme.headlineMedium!),
                ],
              ),
            SizedBox(
              height: 16.h,
            ),
            SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // if (widget.memberdetails.imdb_link.toString() != "false")
                      //   Padding(
                      //     padding: EdgeInsets.only(right: 20.w),
                      //     child: SocialLinks(socialLinks: socialLinks[0]),
                      //   ),
                      if (widget.memberdetails.facebookLink.toString() != "")
                        Padding(
                          padding: EdgeInsets.only(right: 20.w),
                          child: GestureDetector(
                              onTap: () {
                                launchURLMethod(
                                    widget.memberdetails.facebookLink.toString());
                              },
                              child: SocialLinks(socialLinks: socialLinks[1])),
                        ),
                      if (widget.memberdetails.instagramLink.toString() != "")
                        Padding(
                          padding: EdgeInsets.only(right: 20.w),
                          child: GestureDetector(
                              onTap: () {
                                launchURLMethod(
                                    widget.memberdetails.instagramLink.toString());
                              },child: SocialLinks(socialLinks: socialLinks[2])),
                        ),
                      if (widget.memberdetails.youtubeLink.toString() != "")
                        Padding(
                          padding: EdgeInsets.only(right: 20.w),
                          child:GestureDetector(
                              onTap: () {
                                launchURLMethod(
                                    widget.memberdetails.youtubeLink.toString());
                              },child: SocialLinks(socialLinks: socialLinks[3])),
                        ),
                      if (widget.memberdetails.twitterLink.toString() != "")
                        Padding(
                          padding: EdgeInsets.only(right: 20.w),
                          child:GestureDetector(
                              onTap: () {
                                launchURLMethod(
                                    widget.memberdetails.twitterLink.toString());
                              },child: SocialLinks(socialLinks: socialLinks[4])),
                        ),
                      if (widget.memberdetails.linkedinLink.toString() != "")
                        Padding(
                          padding: EdgeInsets.only(right: 0.w),
                          child:GestureDetector(
                              onTap: () {
                                launchURLMethod(
                                    widget.memberdetails.linkedinLink.toString());
                              },child: SocialLinks(socialLinks: socialLinks[5])),
                        )
                    ]
                    //     List.generate(socialLinks.length, (index) {
                    //   return Padding(
                    //     padding: EdgeInsets.only(
                    //         left: index == 0 ? 0 : 20.w),
                    //     child: SocialLinks(
                    //         socialLinks: socialLinks[index]),
                    //   );
                    // }),
                    ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }
}
