import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:pinput/pinput.dart';
import 'package:wingman1/controller.dart';
import 'package:wingman1/custom_snackbar.dart';
import 'package:wingman1/home_repo.dart';
import 'package:wingman1/verify_screen.dart';

class PhoneScreen extends StatelessWidget {
  const PhoneScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController(HomeRepository(Get.find())));
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: CircleAvatar(
                  radius: 40,
                  child: ClipOval(
                    child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSiEndPkpxU-FDOQK0acJ6iuFECTI914xOelQ&usqp=CAU",
                      fit: BoxFit.fill,
                      height: MediaQuery.of(context).size.width/3.6,
                      width: MediaQuery.of(context).size.width/3.6,),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Get Started',style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: homeController.countryController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Text(
                      "|",
                      style: TextStyle(fontSize: 33, color: Colors.grey),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          controller:homeController.phoneNumberController,
                          maxLength: 10,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Phone",
                          ),
                        ))
                  ],
                ),
              ),
            ),
            Center(child: SizedBox(
              width: MediaQuery.of(context).size.width/2,
              child: MaterialButton(
                onPressed: () async {
                  if(homeController.phoneNumberController.text.isNotEmpty && homeController.phoneNumberController.length==10){
                    CustomSnackBar.showSnackBar("Otp", "otp sent succesfully");
                    homeController.sendOtp();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>  MyVerify(phoneNumber: homeController.phoneNumberController.text,)));
                  }else{
                    CustomSnackBar.showSnackBar("PhoneNumber", "enter 10 digit mobile number");
                  }
                },
                child: Text('Continue',style: TextStyle(color: Colors.white),),
                color: Colors.indigo,),
            ))
          ],
        ),
      ),
    );
  }
}
