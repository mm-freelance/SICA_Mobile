import 'dart:convert';

import 'package:sica/utils/app_urls.dart';
import 'package:http/http.dart' as http;

import '../models/EventModel.dart';

class VendorRepo {
  Future<List> getvendors(page) async {
    List res = [];
    try {
      final queryParameters = {
        'db': 'sicadop_02',
        'api_key': '8f4f506e4b4022e154ac3651f9ee006e9b751261'
      };
      var ur = Uri.parse("${AppConstants.baseURL}${AppConstants.vendors}")
          .replace(queryParameters: queryParameters);
      final response = await http.get(ur);
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          final data = jsonDecode(response.body);
          res.add(data["spd_category_details"]);
          return res;

        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }

  Future<List> getSubVendors(page) async {
    List res = [];
    try {
      final queryParameters = {
        'db': 'sicadop_02',
        'api_key': '8f4f506e4b4022e154ac3651f9ee006e9b751261',
        "category_id": page.toString(),
      };
      var ur = Uri.parse("${AppConstants.baseURL}${AppConstants.subVendors}")
          .replace(queryParameters: queryParameters);
      final response = await http.get(ur);
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          final data = jsonDecode(response.body);
          res.add(data["spd_category_details"]);
          return res;

        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }
   Future<List> getProducts(page) async {
    List res = [];
    try {
      final queryParameters = {
        'db': 'sicadop_02',
        'api_key': '8f4f506e4b4022e154ac3651f9ee006e9b751261',
        "sub_category_id": page.toString(),
      };
      var ur = Uri.parse("${AppConstants.baseURL}${AppConstants.products}")
          .replace(queryParameters: queryParameters);
      final response = await http.get(ur);
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          final data = jsonDecode(response.body);
          res.add(data["product_details"]);
          return res;

        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }
   Future<List> getBannerVendorImages() async {
    List res = [];
    try {
      var ur = Uri.parse(
          "${AppConstants.baseURL}${AppConstants.getVendorsImages}");
      final response = await http.get(ur, headers: {
        "content-type": "text/html; charset=utf-8",
      });
      print(response.body);
      switch (response.statusCode) {
        case 200:
          final data = jsonDecode(response.body);
          res.add(data["spd_banner"]);
          return res;

        default:
          return res;
      }
    } catch (e) {
      return res;
    }
  }
}
