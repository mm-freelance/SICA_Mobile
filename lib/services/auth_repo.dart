import 'dart:convert';
import 'package:sica/utils/app_urls.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<List> login(String mobile, String memberid, String accountType,String name) async {
    List userResponse = [];
    try {
      var ur = Uri.parse("${AppConstants.baseURL}${AppConstants.login}?db=sicadop_01&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261&account_type=$accountType&MEMBERSHIP_ID=$memberid&MOBILE_NUMBER=$mobile&guest_name=$name");
      final response = await http.get(ur);
      print(response.statusCode);
    
      switch (response.statusCode) {
        case 200:
          userResponse.add(jsonDecode(response.body));
          return userResponse;

        default:
          return userResponse;
      }
    } catch (e) { return userResponse;}
  }
  Future<List> otpVerify(String token, String otp) async {
    List userResponse = [];
    try {
      var ur = Uri.parse("${AppConstants.baseURL}${AppConstants.verifyOtp}?db=sicadop_02&api_key=8f4f506e4b4022e154ac3651f9ee006e9b751261&OTP=$otp&access_token=$token");
      final response = await http.get(ur);
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          userResponse.add(jsonDecode(response.body));
          return userResponse;

        default:
          return userResponse;
      }
    } catch (e) { return userResponse;}
  }
}
