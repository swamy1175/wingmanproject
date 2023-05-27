import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:wingman1/application_binding.dart';
import 'package:wingman1/phone.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  @override
  void initState() {
    countryController.text = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: ApplicationBinding(),
      debugShowCheckedModeBanner: false,
      home:const PhoneScreen(),
    );
  }

}
