import 'dart:convert';
import 'dart:isolate';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sica/models/BlogsModel.dart';
import 'package:sica/models/DopApprovalModel.dart';
import 'package:sica/models/DopModel.dart';
import 'package:sica/models/JobProviderModel.dart';
import 'package:sica/models/JobSeekeModel.dart';
import 'package:sica/models/JobSeekerProviderMatchModel.dart';
import 'package:sica/models/MemberDetailModel.dart';
import 'package:sica/models/OtherMemberProfile.dart';
import 'package:sica/models/PaymentResponse.dart';
import 'package:sica/models/ProjectTitle.dart';
import 'package:sica/models/ShootingModel.dart';
import 'package:sica/models/ShootingUpdateModel.dart';
import 'package:sica/models/TechModels.dart';
import 'package:sica/utils/app_urls.dart';
import 'package:http/http.dart' as http;
import 'package:sica/views/shooting/add_associate.dart';

import '../models/JobProvider2Model.dart';
import '../models/NewsModel.dart';

class MemberRepo {
  Future<List<MemberDetailModel>> getMemberDetails(memberno) async {
    List<MemberDetailModel> res = [];
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var memberid = (sharedPreferences.getString('memberid') ?? "");
      final queryParameters = {
        'db': 'sicadop_02',
        'api_key': '8f4f506e4b4022e154ac3651f9ee006e9b751261',
        'MEMBERSHIP_ID': memberno == "" ? memberid : memberno,
      };
      var ur = Uri.parse("${AppConstants.baseURL}${AppConstants.memberDetails}")
          .replace(queryParameters: queryParameters);
      final response = await http.get(ur);
      print(response.body);
      switch (response.statusCode) {
        case 200:
          res.add(MemberDetailModel.fromJson(jsonDecode(response.body)));
          return res;

        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }

  Future<List<OtherMemberProfile>> getAllMemberDetails(page) async {
    List<OtherMemberProfile> res = [];
    try {
      final queryParameters = {
        'db': 'sicadop_02',
        'api_key': '8f4f506e4b4022e154ac3651f9ee006e9b751261',
        'offset': "$page",
        'limit': "100"
      };
      var ur = Uri.parse("${AppConstants.baseURL}${AppConstants.getallMember}")
          .replace(queryParameters: queryParameters);
      final response = await http.get(ur);
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          res.add(OtherMemberProfile.fromJson(jsonDecode(response.body)));
          return res;

        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }

  Future<List<OtherMemberProfile>> getAllMemberData() async {
    List<OtherMemberProfile> res = [];
    try {
      final queryParameters = {
        'db': 'sicadop_02',
        'api_key': '8f4f506e4b4022e154ac3651f9ee006e9b751261',
        'offset': "0",
        'limit': "10000"
      };
      var ur = Uri.parse("${AppConstants.baseURL}${AppConstants.getallMember}")
          .replace(queryParameters: queryParameters);
      final response = await http.get(ur);
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          res.add(OtherMemberProfile.fromJson(jsonDecode(response.body)));
          return res;

        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }

  Future<List<JobSeekerProviderMatchModel>> getMatchSeeker(id) async {
    List<JobSeekerProviderMatchModel> res = [];
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var memberid = (sharedPreferences.getString('memberid') ?? "");
    try {
      final queryParameters = {
        'db': 'sicadop_02',
        'api_key': '8f4f506e4b4022e154ac3651f9ee006e9b751261',
        'MEMBERSHIP_ID': memberid,
        'job_provide_id': '$id'
      };
      var ur =
          Uri.parse("${AppConstants.baseURL}${AppConstants.getMatchJobSeeker}")
              .replace(queryParameters: queryParameters);
      final response = await http.get(ur);
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          res.add(
              JobSeekerProviderMatchModel.fromJson(jsonDecode(response.body)));
          return res;

        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }

  Future<List> addSocialLinks(String imdb, String facebook, String insta,
      String youtube, String twiter, String linkedin) async {
    List userResponse = [];
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var memberid = (sharedPreferences.getString('memberid') ?? "");
      var ur = Uri.parse(
          "${AppConstants.baseURL}${AppConstants.socialLinks}?db=sicadop_02&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261&MEMBERSHIP_ID=$memberid&data={'facebook_link':'$facebook','youtube_link':'$youtube','linkedin_link':'$linkedin','twitter_link':'$twiter','instagram_link':'$insta','imdb_link':'$imdb'}");
      final response = await http.post(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          userResponse.add(jsonDecode(response.body));
          return userResponse;

        default:
          return userResponse;
      }
    } catch (e) {
      return userResponse;
    }
  }

  Future<List> updateMembers(
      String mobile,
      String name,
      String memberNo,
      String designation,
      String skills,
      String medium,
      String exp,
      String link,
      String notes,
      String conshow,
      String notshow) async {
    List userResponse = [];
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var memberid = (sharedPreferences.getString('memberid') ?? "");
      var ur = Uri.parse(
          "${AppConstants.baseURL}${AppConstants.updateMember}?db=sicadop_02&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261&MEMBERSHIP_ID=$memberid&data={'member_name': '$name', 'mobile_number': '$mobile', 'membership_no': '$memberNo', 'skills': '$skills', 'designation': '$designation', 'medium': '$medium', 'experience': '$exp', 'portifolio_link': '$link', 'notes': '$notes', 'show_contact': '$conshow','show_notes':'$notshow'}");
      final response = await http.post(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          userResponse.add(jsonDecode(response.body));
          return userResponse;

        default:
          return userResponse;
      }
    } catch (e) {
      return userResponse;
    }
  }

  Future<List> submitJobSeeker(
      String mobile,
      String name,
      String memberNo,
      String designation,
      String postApply,
      String start,
      String end,
      String exp,
      String link,
      String notes,
      String medium,
      List skills,
      String portfolio2,
      String jobseekerid,
      String path) async {
    List userResponse = [];
    try {
      String skilsss = skills.join(', ');
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var memberid = (sharedPreferences.getString('memberid') ?? "");
      var ur;
      if (jobseekerid == "") {
        ur = Uri.parse(
            "${AppConstants.baseURL}${AppConstants.createJobSeeker}?db=sicadop_02&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261&MEMBERSHIP_ID=$memberid&data={'membership_no':'$memberNo','mobile_number':'$mobile','grade':'$designation','member_name':'$name','post_apply':'$postApply','experience':'$exp','portifolio_link':'$link','note':'$notes','document_binary':'$path','availability_from':'$start','availability_till':'$end','format_id':'$medium','skills':'$skilsss','portifolio_link_2':'$portfolio2'}");
      } else {
        ur = Uri.parse(
            "${AppConstants.baseURL}/post/job_seeker?db=sicadop_02&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261&MEMBERSHIP_ID=$memberid&data={'membership_no':'$memberNo','mobile_number':'$mobile','grade':'$designation','member_name':'$name','post_apply':'$postApply','experience':'$exp','portifolio_link':'$link','note':'$notes','document_binary':'$path','availability_from':'$start','availability_till':'$end','format_id':'$medium','skills':'$skilsss','portifolio_link_2':'$portfolio2','job_seeker_id':'$jobseekerid'}");
      }
      final response = await http.post(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.body);
      switch (response.statusCode) {
        case 200:
          userResponse.add(jsonDecode(response.body));
          return userResponse;

        default:
          return userResponse;
      }
    } catch (e) {
      return userResponse;
    }
  }

  Future<List> addWork(
    String name,
    String year,
    String designation,
  ) async {
    List userResponse = [];
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var memberid = (sharedPreferences.getString('memberid') ?? "");
      var ur = Uri.parse(
          "${AppConstants.baseURL}${AppConstants.createProject}?db=sicadop_02&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261&MEMBERSHIP_ID=$memberid&data={'project_name': '$name', 'year': '$year', 'designation': '$designation'}");
      final response = await http.post(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          userResponse.add(jsonDecode(response.body));
          return userResponse;

        default:
          return userResponse;
      }
    } catch (e) {
      return userResponse;
    }
  }

  Future<List> addAssociate(
    String shootingid,
    String name,
    String memberno,
    String mobile,
  ) async {
    List userResponse = [];
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var memberid = (sharedPreferences.getString('memberid') ?? "");
      var ur = Uri.parse(
          "${AppConstants.baseURL}${AppConstants.createAssociate}?db=sicadop_02&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261&MEMBERSHIP_ID=$memberid&shooting_id=$shootingid&data={'name': '$name', 'mobile_number': '$mobile', 'member_number': '$memberno'}");
      final response = await http.post(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.body);
      switch (response.statusCode) {
        case 200:
          userResponse.add(jsonDecode(response.body));
          return userResponse;

        default:
          return userResponse;
      }
    } catch (e) {
      return userResponse;
    }
  }

  Future<List> editWork(
      String name, String year, String designation, int id) async {
    List userResponse = [];
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var memberid = (sharedPreferences.getString('memberid') ?? "");
      var ur = Uri.parse(
          "${AppConstants.baseURL}${AppConstants.updateProject}?db=sicadop_02&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261&MEMBERSHIP_ID=$memberid&data={'project_name': '$name', 'year': '$year', 'designation': '$designation'}&ID=$id");
      final response = await http.post(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          userResponse.add(jsonDecode(response.body));
          return userResponse;

        default:
          return userResponse;
      }
    } catch (e) {
      return userResponse;
    }
  }

  Future<List> deleteWork(
      String name, String year, String designation, int id) async {
    List userResponse = [];
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var memberid = (sharedPreferences.getString('memberid') ?? "");
      var ur = Uri.parse(
          "${AppConstants.baseURL}${AppConstants.deleteProject}?db=sicadop_02&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261&MEMBERSHIP_ID=$memberid&data={'project_name': '$name', 'year': '$year', 'designation': '$designation'}&ID=$id");
      final response = await http.delete(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          userResponse.add(jsonDecode(response.body));
          return userResponse;

        default:
          return userResponse;
      }
    } catch (e) {
      return userResponse;
    }
  }

  Future<List<JobProvider2Model>> getJobProviders() async {
    List<JobProvider2Model> res = [];
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var memberid = (sharedPreferences.getString('memberid') ?? "");
      final queryParameters = {
        'db': 'sicadop_02',
        'api_key': '8f4f506e4b4022e154ac3651f9ee006e9b751261',
        'MEMBERSHIP_ID': memberid
      };
      var ur =
          Uri.parse("${AppConstants.baseURL}${AppConstants.getJobProvider}")
              .replace(queryParameters: queryParameters);
      final response = await http.get(ur);
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          res.add(JobProvider2Model.fromJson(jsonDecode(response.body)));
          return res;

        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }

  Future<List<JobSeekeModel>> getJobSeekers() async {
    List<JobSeekeModel> res = [];
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var memberid = (sharedPreferences.getString('memberid') ?? "");
      final queryParameters = {
        'db': 'sicadop_02',
        'api_key': '8f4f506e4b4022e154ac3651f9ee006e9b751261',
        'MEMBERSHIP_ID': memberid
      };
      var ur = Uri.parse("${AppConstants.baseURL}${AppConstants.getJobSeeker}")
          .replace(queryParameters: queryParameters);
      final response = await http.get(ur);
      print(response.body);
      switch (response.statusCode) {
        case 200:
          res.add(JobSeekeModel.fromJson(jsonDecode(response.body)));
          return res;

        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }

  Future<List<DopApprovalModel>> getApprovalList() async {
    List<DopApprovalModel> res = [];
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var memberid = (sharedPreferences.getString('memberid') ?? "");
      final queryParameters = {
        'db': 'sicadop_02',
        'api_key': '8f4f506e4b4022e154ac3651f9ee006e9b751261',
        'DOP_MEMBERSHIP_ID': memberid
      };
      var ur =
          Uri.parse("${AppConstants.baseURL}${AppConstants.getApprovalList}")
              .replace(queryParameters: queryParameters);
      final response = await http.get(ur);
      print(response.body);
      switch (response.statusCode) {
        case 200:
          res.add(DopApprovalModel.fromJson(jsonDecode(response.body)));
          return res;

        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }

  Future<List<ShootingUpdateModel>> getShootingUpdates() async {
    List<ShootingUpdateModel> res = [];
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var memberid = (sharedPreferences.getString('memberid') ?? "");
      final queryParameters = {
        'db': 'sicadop_02',
        'api_key': '8f4f506e4b4022e154ac3651f9ee006e9b751261',
        'MEMBERSHIP_ID': memberid
      };
      var ur =
          Uri.parse("${AppConstants.baseURL}${AppConstants.getShootingUpdates}")
              .replace(queryParameters: queryParameters);
      final response = await http.get(ur);
      print(response.body);
      switch (response.statusCode) {
        case 200:
          res.add(ShootingUpdateModel.fromJson(jsonDecode(response.body)));
          return res;

        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }

  Future<List<ProjectTitle>> getProjectTitle(text) async {
    List<ProjectTitle> res = [];
    try {
      final queryParameters = {
        'db': 'sicadop_02',
        'api_key': '8f4f506e4b4022e154ac3651f9ee006e9b751261',
        'shooting_title': text
      };
      var ur =
          Uri.parse("${AppConstants.baseURL}${AppConstants.getProjectTitle}")
              .replace(queryParameters: queryParameters);
      final response = await http.get(ur);
      switch (response.statusCode) {
        case 200:
          res.add(ProjectTitle.fromJson(jsonDecode(response.body)));
          return res;
        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }

  Future<List> getJobPosts() async {
    List res = [];
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var memberid = (sharedPreferences.getString('memberid') ?? "");
      final queryParameters = {
        'db': 'sicadop_02',
        'api_key': '8f4f506e4b4022e154ac3651f9ee006e9b751261',
        'MEMBERSHIP_ID': memberid
      };
      //Skills
      var ur = Uri.parse("${AppConstants.baseURL}${AppConstants.getJobsPost}")
          .replace(queryParameters: queryParameters);
      final response = await http.get(ur);
      switch (response.statusCode) {
        case 200:
          final data = jsonDecode(response.body);
          res.add(data["Job Post"]);
          return res;
        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }

  Future<List> getSkills() async {
    List res = [];
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var memberid = (sharedPreferences.getString('memberid') ?? "");
      final queryParameters = {
        'db': 'sicadop_02',
        'api_key': '8f4f506e4b4022e154ac3651f9ee006e9b751261',
        'MEMBERSHIP_ID': memberid
      };
      //Skills
      var ur = Uri.parse("${AppConstants.baseURL}${AppConstants.getSkills}")
          .replace(queryParameters: queryParameters);
      final response = await http.get(ur);
      switch (response.statusCode) {
        case 200:
          final data = jsonDecode(response.body);
          res.add(data["Skills"]);
          return res;
        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }

  Future<List> submitJobProvider(
      String mobile,
      String name,
      String memberNo,
      String designation,
      List skills,
      String medium,
      String exp,
      String projectreq,
      String notes,
      String portfiliolink,
      String startdate,
      String enddate) async {
    List userResponse = [];
    try {
      String skilsss = skills.join(', ');
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var memberid = (sharedPreferences.getString('memberid') ?? "");
      var ur = Uri.parse(
          "${AppConstants.baseURL}${AppConstants.addJobProvider}?db=sicadop_02&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261&MEMBERSHIP_ID=$memberid&data={'membership_no': '$memberNo', 'mobile_number': '$mobile', 'grade': '$designation', 'member_name': '$name', 'skill': '$skilsss', 'outdoor_link': '$portfiliolink', 'note': '$notes', 'post_required': '$projectreq', 'format_id': '$medium' ,  'required_from': '$startdate', 'required_till': '$enddate'}");
      final response = await http.post(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          userResponse.add(jsonDecode(response.body));
          return userResponse;

        default:
          return userResponse;
      }
    } catch (e) {
      return userResponse;
    }
  }

  Future<List<PaymentResponse>> createPayment() async {
    List<PaymentResponse> res = [];
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var memberid = (sharedPreferences.getString('memberid') ?? "");
    try {
      final queryParameters = {
        'db': 'sicadop_02',
        'api_key': '8f4f506e4b4022e154ac3651f9ee006e9b751261',
        'MEMBERSHIP_ID': "$memberid"
      };
      var ur = Uri.parse("${AppConstants.baseURL}${AppConstants.createPayment}")
          .replace(queryParameters: queryParameters);
      final response = await http.get(ur);
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          res.add(PaymentResponse.fromJson(jsonDecode(response.body)));
          return res;

        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }

  Future<List<PaymentResponse>> createEventPayment(eventid) async {
    List<PaymentResponse> res = [];
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var memberid = (sharedPreferences.getString('memberid') ?? "");
    try {
      final queryParameters = {
        'db': 'sicadop_02',
        'api_key': '8f4f506e4b4022e154ac3651f9ee006e9b751261',
        'MEMBERSHIP_ID': "$memberid",
        'event_id': eventid
      };
      var ur =
          Uri.parse("${AppConstants.baseURL}${AppConstants.getEventPayment}")
              .replace(queryParameters: queryParameters);
      final response = await http.get(ur);
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          res.add(PaymentResponse.fromJson(jsonDecode(response.body)));
          return res;

        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }

  Future<List> submitShooting(
      String dopname,
      String dopmemno,
      String producer,
      String prohouse,
      String producerExt,
      String producerExtContact,
      String mobile,
      String name,
      String memberNo,
      String designation,
      String projectName,
      String medium,
      String date,
      String grade,
      String notes,
      String loaction,
      String outdoor) async {
    List userResponse = [];
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var memberid = (sharedPreferences.getString('memberid') ?? "");
      var ur = Uri.parse(
          "${AppConstants.baseURL}${AppConstants.createShooting}?db=sicadop_02&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261&MEMBERSHIP_ID=$memberid&data={ 'date': '$date', 'mobile_number': '$mobile' , 'member_name': '$name' , 'member_number':'$memberNo' , 'designation':'$designation', 'grade': '$grade', 'dop_name': '$dopname', 'dop_member_number': '$dopmemno' , 'project_title':'$projectName', 'format_id': '$medium' ,  'producer': '$producer', 'production_house': '$prohouse', 'production_executive': '$producerExt', 'production_executive_contact_no': '$producerExtContact', 'location': '$loaction', 'outdoor_unit_name': '$outdoor', 'notes': '$notes' }");
      final response = await http.post(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.body);
      switch (response.statusCode) {
        case 200:
          userResponse.add(jsonDecode(response.body));
          return userResponse;

        default:
          return userResponse;
      }
    } catch (e) {
      return userResponse;
    }
  }

  Future<List> submitDop(
      String date,
      String mobile,
      String name,
      String memberNo,
      String designation,
      String projectName,
      String medium,
      String startdate,
      String endDate,
      String outdoorlink,
      String producer,
      String proContact,
      String location,
      String prohouse,
      String proexe,
      List associates) async {
    List userResponse = [];
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var memberid = (sharedPreferences.getString('memberid') ?? "");
      // final queryParameters = {
      //   'db': 'sicadop_02',
      //   'api_key': '8f4f506e4b4022e154ac3651f9ee006e9b751261',
      //   'MEMBERSHIP_ID': "$memberid",
      //   'data':
      //       "{'shooting_id': 5,'mobile_number': '$mobile', 'member_name': '$name', 'member_number': '$memberNo', 'designation': '$designation', 'project_title': '$projectName', 'medium_id': '$medium', 'start_date': '$startdate', 'end_date': '$endDate', 'outdoor_link_details': '$outdoorlink', 'no_of_associate' : ${associates.length}, 'associate': '$associates'}"
      // };
      List array = [];
      for (int i = 0; i < associates.length; i++) {
        var json = {
          'name': '${associates[i]["name"]}',
          'mobile_number': '${associates[i]["mobile_number"]}',
          'member_number': '${associates[i]["member_number"]}',
          'role_type': '${associates[i]["role"]}'
        };
        array.add(jsonEncode(json));
      }
      var ur = Uri.parse(
          "${AppConstants.baseURL}${AppConstants.createDop}?db=sicadop_02&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261&MEMBERSHIP_ID=$memberid&data={'date':'$date','mobile_number': '$mobile', 'member_name': '$name', 'member_number': '$memberNo', 'grade': '$designation', 'project_title': '$projectName','format_id': '$medium', 'schedule_start': '$startdate', 'schedule_end': '$endDate', 'outdoor_link_details': '$outdoorlink','project_house': '$prohouse', 'production_executive': '$proexe', 'production_executive_contact_no': '$proContact', 'outdoor_unit_name': '$outdoorlink', 'location': '$location',  'producer': '$producer',  'associate':$array}");
      final response = await http.post(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.body);
      switch (response.statusCode) {
        case 200:
          userResponse.add(jsonDecode(response.body));
          return userResponse;

        default:
          return userResponse;
      }
    } catch (e) {
      return userResponse;
    }
  }

  Future<List> getMediumService() async {
    List res = [];
    try {
      var ur = Uri.parse(
          "${AppConstants.baseURL}${AppConstants.medium}?db=sicadop_02&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261");
      final response = await http.get(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          final data = jsonDecode(response.body);
          res.add(data["medium_details"]);
          return res;

        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }

  Future<List> getShootingImages() async {
    List res = [];
    try {
      var ur =
          Uri.parse("${AppConstants.baseURL}${AppConstants.getShootingImages}");
      final response = await http.get(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          final data = jsonDecode(response.body);
          res.add(data["Shooting Image"]);
          return res;

        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }

  Future<List<NewsModel>> getNews() async {
    List<NewsModel> res = [];
    try {
      var ur = Uri.parse(AppConstants.baseURL + AppConstants.newsApi);
      final response = await http.get(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          final data = jsonDecode(response.body);
          res.add(NewsModel.fromJson(data));
          return res;

        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }

  Future<List<BlogsModel>> getBlogs() async {
    List<BlogsModel> res = [];
    try {
      var ur = Uri.parse(AppConstants.baseURL + AppConstants.blogsApi);
      final response = await http.get(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          final data = jsonDecode(response.body);
          res.add(BlogsModel.fromJson(data));
          return res;

        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }

  Future<List<TechModel>> getTechNews() async {
    List<TechModel> res = [];
    try {
      var ur = Uri.parse(AppConstants.baseURL + AppConstants.techTalk);
      final response = await http.get(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          final data = jsonDecode(response.body);
          res.add(TechModel.fromJson(data));
          return res;

        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }

  Future<List<DopModel>> getDops() async {
    List<DopModel> res = [];
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      var memberid = (sharedPreferences.getString('memberid') ?? "");
      var ur = Uri.parse(
          "${AppConstants.baseURL}${AppConstants.getShootingdop}?db=sicadop_02&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261&MEMBERSHIP_ID=$memberid");
      final response = await http.get(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          final data = jsonDecode(response.body);
          res.add(DopModel.fromJson(data));
          return res;

        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }

  Future<List<ShootingModel>> getShootings() async {
    List<ShootingModel> res = [];
    try {
      var ur = Uri.parse(
          "${AppConstants.baseURL}${AppConstants.getShooting}?db=sicadop_02&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261");
      final response = await http.get(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          final data = jsonDecode(response.body);
          res.add(ShootingModel.fromJson(data));
          return res;

        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }

  Future<List<DopApprovalModel>> getApprovalService() async {
    List<DopApprovalModel> res = [];
    try {
      var ur = Uri.parse(
          "${AppConstants.baseURL}${AppConstants.getApproval}?db=sicadop_02&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261");
      final response = await http.get(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          final data = jsonDecode(response.body);
          res.add(DopApprovalModel.fromJson(data));
          return res;

        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }

  Future<List> getBannerImages() async {
    List res = [];
    try {
      var ur = Uri.parse(
          "${AppConstants.baseURL}${AppConstants.getBanners}?db=sicadop_02&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261");
      final response = await http.get(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.body);
      switch (response.statusCode) {
        case 200:
          final data = jsonDecode(response.body);
          res.add(data["photo"]);
          return res;

        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }

  Future<List> getPayments() async {
    List res = [];
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var memberid = (sharedPreferences.getString('memberid') ?? "");
      var ur = Uri.parse(
          "${AppConstants.baseURL}/member/payment_information/$memberid");
      final response = await http.get(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.body);
      switch (response.statusCode) {
        case 200:
          final data = jsonDecode(response.body);
          res.add(data["member_payment_details"]);
          return res;

        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }

  Future<List> getReasons() async {
    List res = [];
    try {
      var ur = Uri.parse(
          "${AppConstants.baseURL}${AppConstants.getReasons}?db=sicadop_02&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261");
      final response = await http.get(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          final data = jsonDecode(response.body);
          res.add(data["grievance_reason_details"]);
          return res;

        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }

  Future<List> createReason(
      String reasonid,
      String memberNo,
      String name,
      String projectName,
      String productionHouse,
      String outdoorUnit,
      String location,
      String issueType,
      String approx,
      String managerContact,
      String solveIssue,
      String reportedIssue,
      String productionContact,
      String briefIssue) async {
    List userResponse = [];
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var memberid = (sharedPreferences.getString('memberid') ?? "");
      var ur = Uri.parse(
          "${AppConstants.baseURL}${AppConstants.createGrievance}?db=sicadop_02&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261&MEMBERSHIP_ID=$memberid&Reason_id=$reasonid&data={'member_name_no': '$memberNo', 'name': '$name', 'project_name': '$projectName', 'projection_house_name': '$productionHouse', 'outdoor_unit_name': '$outdoorUnit', 'location': '$location', 'contact_outdoor_unit_manager': '$managerContact', 'approximate_time_lost': '$approx', 'has_outdoor_unit_manager_helpful_to_the_solve_issue': '$solveIssue', 'name_contact_no_of_production_manager_executive_producer': '$productionContact', 'brief_issue_faced_with_service_of_outdoor_unit_equipment': '$briefIssue', 'issue_has_been_reported': '$reportedIssue', 'issue_type': '$issueType'}");
      final response = await http.post(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.body);
      switch (response.statusCode) {
        case 200:
          userResponse.add(jsonDecode(response.body));
          return userResponse;

        default:
          return userResponse;
      }
    } catch (e) {
      return userResponse;
    }
  }

  Future<List> createShootingReason(
      String reasonid,
      String memberNo,
      String name,
      String contact,
      String email,
      String projectName,
      String category,
      String format,
      String designation,
      String producer,
      String projectHouse,
      String productionExecutive,
      String productionContact,
      String outdorrlink,
      String location) async {
    List userResponse = [];
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var memberid = (sharedPreferences.getString('memberid') ?? "");
      var ur = Uri.parse(
          "${AppConstants.baseURL}${AppConstants.createGrievance}?db=sicadop_02&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261&MEMBERSHIP_ID=0024&Reason_id=$reasonid&data={'date': '26/01/2023', 'member_contact_no': '$contact', 'member_name': '$name', 'email': '$email', 'membership_no': '$memberNo', 'category': '$category', 'project_title': '$projectName', 'format': '$format', 'designation': '$designation', 'producer': '$producer', 'project_house': '$projectHouse', 'production_executive': '$productionExecutive', 'production_executive_contact_no': '$productionContact', 'outdoor_unit_name': '$outdorrlink', 'location': '$location', 'reason_id': '$reasonid'}");
      final response = await http.post(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.body);
      switch (response.statusCode) {
        case 200:
          userResponse.add(jsonDecode(response.body));
          return userResponse;

        default:
          return userResponse;
      }
    } catch (e) {
      return userResponse;
    }
  }

  Future<List> updateApprovalService(
      String shooting_dop_id, String status) async {
    List userResponse = [];
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var memberid = (sharedPreferences.getString('memberid') ?? "");
      var ur = Uri.parse(
          "${AppConstants.baseURL}${AppConstants.updateApproval}?db=sicadop_02&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261&DOP_MEMBERSHIP_ID=$memberid&update_shooting_id=$shooting_dop_id&status_move=$status");
      final response = await http.post(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.body);
      switch (response.statusCode) {
        case 200:
          userResponse.add(jsonDecode(response.body));
          return userResponse;

        default:
          return userResponse;
      }
    } catch (e) {
      return userResponse;
    }
  }
}


//1. approval remove
//2. get data job providee edit, match data
// change desi to grade

//add feild to dop create - pro house, producer, production_executive_contact_no,production_
//executive,outdoor_unit_name,outdoor link to location,shooting_title=null, member_contact_no=null, email=null,membership_no=null

//4. news apis