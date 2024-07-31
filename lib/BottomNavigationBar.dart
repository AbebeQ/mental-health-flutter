import 'package:mwntalassessment/ArticlesPage.dart';

import 'package:mwntalassessment/HomeScreen.dart';
import 'package:mwntalassessment/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mwntalassessment/pages/activities_page.dart';

import 'pages/user_profile_page.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const UserData(),
    const Articles(),
    const ActivitiesScreen(),
     Profile(),
  ];

  void getcredentials() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('Users')
        .doc('${patientInfo.email}')
        .get();
    setState(() {
      patientInfo.name = doc['name'];
      patientInfo.address = doc['friend'];
      patientInfo.biography = doc['friendContact'];
      patientInfo.phoneNo = doc['friendPhone'];
      patientInfo.gender = doc['specialist'];

    });
  }

  @override
  void initState() {
    getcredentials();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.blueAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Articles',
            backgroundColor: Colors.blueAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_activity),
            label: 'Activities',
            backgroundColor: Colors.blueAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: Colors.blueAccent,
          ),
        ],
        selectedItemColor: Colors.redAccent.withOpacity(0.8),
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
