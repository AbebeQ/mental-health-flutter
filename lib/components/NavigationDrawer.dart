
// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mwntalassessment/Account/login_page.dart';
import 'package:mwntalassessment/IntroScreen.dart';
import '../Assessment.dart';
import '../ContactExpert.dart';
import '../pages/hero_page.dart';
import '../components/helpers/info.dart';


class Topdrawer extends StatefulWidget {
  const Topdrawer({super.key});

  @override
  State<Topdrawer> createState() => _TopdrawerState();
}

class _TopdrawerState extends State<Topdrawer> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    Color color = Colors.black;
    return  Drawer(
      backgroundColor: Colors.white,
      child: Container(
        color: Colors.black26,
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                child: Row(
                  children: [
                    const Icon(
                      Icons.phone,
                      color: Colors.black,
                      size: 25,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Contact Experts',
                      textScaleFactor: 1,
                      style: TextStyle(fontSize: 25, color: color),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => ContactExpertPage()));
                },
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                child: Row(
                  children: [
                    const Icon(
                      Icons.self_improvement,
                      color: Colors.black,
                      size: 25,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Helps',
                      textScaleFactor: 1,
                      style: TextStyle(fontSize: 25, color: color),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const InfoScreen()));
                },
              ),
              const SizedBox(
                height: 20,
              ),


              InkWell(
                child: Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.lock,
                      color: Colors.black,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Log Out',
                      textScaleFactor: 1,
                      style: TextStyle(fontSize: 25, color: color),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                child: Row(
                  children: [
                    const Icon(
                      Icons.delete_forever_sharp,
                      color: Colors.red,
                      size: 25,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Exit',
                      textScaleFactor: 1,
                      style: TextStyle(fontSize: 25, color: color),
                    ),
                  ],
                ),
                onTap: () {

                  Navigator.pop(context);
                  exit(0);
                },
              ),

              const SizedBox(height: 1,),
              SizedBox(height: height / 150),

            ],
          ),
        ),
      ),
    );
  }
}
