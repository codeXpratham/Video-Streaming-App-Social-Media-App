import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peo_veo/constants/constant.dart';
import 'package:peo_veo/controllers/auth_controller.dart';
import 'package:peo_veo/views/screens/auth/login_screen.dart';
import 'package:peo_veo/views/screens/auth/signUP.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp().then((value) => () {
  //   Get.put(AuthController());
    // Get.lazyPut(()=>AuthController());
  // await Firebase.initializeApp().then((value) => () {
  //   Get.put(AuthController());
  // });
  // runApp(const MyApp());
  await Firebase.initializeApp().then((value) {
    Get.put(AuthController());
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColour,
      ),

      home: LoginScreen(),
    );
  }
}

