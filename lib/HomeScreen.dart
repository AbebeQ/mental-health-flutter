// ignore_for_file: deprecated_member_use, avoid_types_as_parameter_names, prefer_for_elements_to_map_fromiterable, unnecessary_this, non_constant_identifier_names, use_key_in_widget_constructors

import 'dart:async';
import 'dart:convert';

import 'package:mwntalassessment/components/NavigationDrawer.dart';
import 'package:mwntalassessment/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mwntalassessment/pages/functionality.dart';
import 'package:url_launcher/url_launcher.dart';

class UserData extends StatefulWidget {
  const UserData({Key? key}) : super(key: key);

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mental Health Tracker',
            style: TextStyle(
                fontSize: 23.0,
                fontWeight: FontWeight.w900)),
        centerTitle: true,
        backgroundColor: Colors.redAccent.withOpacity(0.8),
      ),
      drawer: const Menu(),
      body: const Functionality(),
    );
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class DataValue extends StatelessWidget {
  const DataValue({
    required this.data,
    required this.dataName,
    required this.dataIcon,
  });

  final String data;
  final String dataName;
  final IconData dataIcon;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Container(
      width: width / 2.3,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200]!.withOpacity(0.7),
      ),
      child: Column(
        children: [
          Icon(dataIcon, size: 0.174 * width, color: Colors.pink[600]),
          SizedBox(height: height / 40),
          Text(
            dataName,
            style: TextStyle(
              fontSize: 0.036 * width,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: height / 40),
          Text(data),
        ],
      ),
    );
  }
}

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return const Topdrawer();
  }
}
