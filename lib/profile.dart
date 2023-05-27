import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:wingman1/controller.dart';
import 'package:wingman1/custom_snackbar.dart';
import 'package:wingman1/welcome.dart';

class Profile extends StatelessWidget {
   Profile({Key? key}) : super(key: key);

  HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Welcome',style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Looks like you are new here.Tell us bit about yourself.",style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller:homeController.nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Name",
                ),
              ),
            ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller:homeController.emailController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "email id",
            ),
          ),
        ),
            SizedBox(
              width: MediaQuery.of(context).size.width/2,
              child: MaterialButton(
                onPressed: () async {
                  if(homeController.nameController.text.isEmpty){
                    CustomSnackBar.showSnackBar("name", "name required");
                  } else if (homeController.emailController.text.isEmpty){
                    CustomSnackBar.showSnackBar("email", "email id requierd");
                  }else{
                    homeController.profileSubmit().then((value){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> WelcomeScreen()));
                    });
                  }
                },
                child: Text("Submit",style: TextStyle(color: Colors.white),),color: Colors.indigo,),
            )
          ],
        ),
      ),
    );
  }
}
