import 'package:flutter/material.dart';
import 'package:mwntalassessment/HomeScreen.dart';
import 'package:mwntalassessment/components/custom_list_tile.dart';
import 'package:mwntalassessment/Activities/breathing_screen.dart';
import 'package:mwntalassessment/Activities/goal_screen.dart';
import 'package:mwntalassessment/Activities/meditation_screen.dart';
import 'package:mwntalassessment/Activities/quiz/quiz.dart';

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(


        title: const Text('Some Activities '),
        centerTitle: true,
        backgroundColor: Colors.redAccent.withOpacity(0.8),
      ),
      drawer: const Menu(),
      body: ListView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        children: const [
          CustomListTile(
            path: 'assets/animations/meditation-timer.json',
            title: 'Meditation',
            subtitle: 'Finding Peace Within deep way',
            screen: MeditationScreen(),
          ),

          CustomListTile(
              path: 'assets/animations/target.json',
              title: 'Goals',
              subtitle: 'Dream BIg',
              screen: GoalScreen()),
          CustomListTile(
            path: 'assets/animations/breathing-icon.json',
            title: 'Breathing',
            subtitle: 'Breathing',
            screen: BreathingScreen(),
          ),
          CustomListTile(
              path: 'assets/animations/quiz.json',
              title: 'Question for Refreshment of self',
              subtitle: '',
              screen: Quiz())
          // CustomListTile(),
        ],
      ),
    );
  }
}
