import 'package:mwntalassessment/Account/ExpertRegister.dart';
import 'package:mwntalassessment/BottomNavigationBar.dart';
import 'package:mwntalassessment/IntroScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Account/login_or_register_page.dart';
import 'admin_page.dart';
import 'assessment/UI/expert_system.dart';
import 'wellcomescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyBHdOvaMGgCc2Ckj9P4RL64Ayl2L40uRw0',
      appId: '1:594960202743:android:8f2240e3af142d2017ccf2',
      messagingSenderId: '594960202743',
      projectId: 'mentalhealth-28368',
      storageBucket: 'mentalhealth-28368.appspot.com',
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home:Access(),
    );
  }
}

class Access extends StatefulWidget {
  @override
  State<Access> createState() => _AccessState();
}

class _AccessState extends State<Access> {
  bool userAvailable = false;
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    sharedPreferences = await SharedPreferences.getInstance();

    try {
      if (sharedPreferences.getString("mental101") != null) {
        setState(() {
          patientInfo.email = sharedPreferences.getString("mental101")!;
          userAvailable = true;
        });
      }
    } catch (e) {
      setState(() {
        userAvailable = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return userAvailable ? const Homescreen() : const Intro();
  }
}

class patientInfo {
  static String? name;
  static int? age;
  static String? email;
  static String? phoneNo;
  static String? address;
  static String? gender;
  static String? biography;
  // ignore: non_constant_identifier_names
  static String? profile_link;
}
