
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wingman1/custom_snackbar.dart';
import 'package:wingman1/home_repo.dart';

class HomeController extends GetxController{
final HomeRepository homeRepository;
  HomeController(this.homeRepository);

TextEditingController countryController = TextEditingController();
TextEditingController phoneNumberController = TextEditingController();
TextEditingController otpController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
String requestId = '';
bool? profileExist;
String jwtToken = '';
List otpResponse = [];
@override
  void onInit() {
  countryController.text = "+91";
  super.dispose();
  }

  Future sendOtp() async {
    var map = <String, dynamic>{};
    map["mobile"] = phoneNumberController.text;
    homeRepository.sendOtp(map).then((value){
      if(value!=null){
        requestId = value.requestId!;
      }
    });
  }

Future verifyOtp() async {
  var map = <String, dynamic>{};
  map["request_id"] = requestId;
  map["code"] =otpController.text;
  return await homeRepository.verifyOtp(map);
}

Future profileSubmit() async {
  var map = <String, dynamic>{};
  map["name"] = nameController.text;
  map["email"] =emailController.text;
  return await homeRepository.profileSubmit(map);
}
}