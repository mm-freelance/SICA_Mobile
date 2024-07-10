import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:sica/utils/app_urls.dart';
import 'package:http/http.dart' as http;

import '../models/EventModel.dart';
import '../models/GalleryModel.dart';

class GalleryRepo {
  Future<List<GalleryModel>> getGalleryData(cat) async {
    List<GalleryModel> res = [];
    try {
        SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var memberid = (sharedPreferences.getString('memberid') ?? "");
      final queryParameters = {
        'db': 'sicadop_02',
        'api_key': '8f4f506e4b4022e154ac3651f9ee006e9b751261',
        'category_id': '$cat',
        'MEMBERSHIP_ID':'$memberid'
      };
      var ur = Uri.parse("${AppConstants.baseURL}${AppConstants.galleryData}")
          .replace(queryParameters: queryParameters);
      final response = await http.get(ur);
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          final data = jsonDecode(response.body);
          res.add(GalleryModel.fromJson(data));
          return res;
        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }
   Future<List> getGalleryCategory() async {
    List res = [];
    try {
      var ur = Uri.parse("${AppConstants.baseURL}${AppConstants.getGalleryCategory}");
      final response = await http.get(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.body);
      switch (response.statusCode) {
        case 200:
          final data = jsonDecode(response.body);
          res.add(data["gallery_category_details"]);
          return res;

        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }
}
