import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wingman1/controller.dart';
import 'package:wingman1/custom_snackbar.dart';
import 'package:wingman1/phone.dart';
import 'package:wingman1/profile.dart';
import 'package:wingman1/verification_model.dart';
import 'package:wingman1/welcome.dart';

class MyVerify extends StatefulWidget {
  final String? phoneNumber;
  const MyVerify({Key? key,required this.phoneNumber}) : super(key: key);

  @override
  State<MyVerify> createState() => _MyVerifyState();
}
HomeController homeController = Get.find();


class _MyVerifyState extends State<MyVerify> {
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
              Text(
                "otp sent to +91${widget.phoneNumber}",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Pinput(
                length: 6,
                controller: homeController.otpController,
                showCursor: true,
                onCompleted: (pin) => print(pin),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green.shade600,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      VerificationModel? verifcationModel;
                      await homeController.verifyOtp().then((value){
                        verifcationModel=value;
                        if(value!=null && verifcationModel?.status == true){
                          CustomSnackBar.showSnackBar("otp", "otp verified succesfully");
                          if(verifcationModel!.profileExists==false){
                            prefs.setString('jwtValue', verifcationModel!.jwt.toString());
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Profile()),
                            );}else{
                            prefs.setString('jwtValue', verifcationModel!.jwt.toString());
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => WelcomeScreen()),
                            );
                          }
                        }else{
                          CustomSnackBar.showSnackBar("otp", "enter correct otp");

                        }
                      });
                    },
                    child: Text("Verify Phone Number")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}