import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';
import 'package:wingman1/jwt_model.dart';
import 'package:wingman1/otp.dart';
import 'package:wingman1/verification_model.dart';
import 'package:wingman1/verify_screen.dart';


class HomeRepository {
  final Dio _dio;
  HomeRepository(this._dio);

  Future<Otp>sendOtp(body) async {
    print('enterd 111');
    var response = await _dio.post("https://test-otp-api.7474224.xyz/sendotp.php",data: jsonEncode(body));
    print('enterd 1111 $response');
    //log('upload_response ${response.data.status}');
    /*final otpResp = {
      "status": response.data.status,
      "response": response.data.response,
      "request_id": response.data.request_id
    };*/

    if(response.statusCode==200){
      return Otp.fromJson(jsonDecode(response.data));
    }else{
      throw Exception('swamy response error ');
    }
  }

  Future<VerificationModel>verifyOtp(body) async {
    print('enterd 111');
    var response = await _dio.post("https://test-otp-api.7474224.xyz/verifyotp.php",data: jsonEncode(body));
    print('enterd 1111 $response');
    log('upload_response ${response.toString()}');
    if(response.statusCode==200){
      return VerificationModel.fromJson(jsonDecode(response.data));
    }else{
      throw Exception('swamy response error ');
    }
  }

  Future<JwtResponse>profileSubmit(body) async {
    print('enterd 111');
    var response = await _dio.post("https://test-otp-api.7474224.xyz/profilesubmit.php",data: jsonEncode(body),options: Options(
      headers: {
        "Token": "jwt1235",
      }
    ));
    print('enterd 1111 $response');
    log('upload_response ${response.toString()}');
    if(response.statusCode==200){
      return JwtResponse.fromJson(jsonDecode(response.data));
    }else{
      throw Exception('swamy response error ');
    }
  }


}