
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';


// final _firestore = FirebaseFirestore.instance;
// User? loggedInUser;

class MeditationScreen extends StatefulWidget {
  const MeditationScreen({super.key});

  @override
  State<MeditationScreen> createState() => _MeditationScreenState();
}

class _MeditationScreenState extends State<MeditationScreen> {
  final int _duration = 30;
 // final _auth = FirebaseAuth.instance;
  final CountDownController _controller = CountDownController();

  @override
  void initState() {
    super.initState();
  //  getCurrentUser();
  }

  // void getCurrentUser() {
  //   try {
  //     final user = _auth.currentUser;
  //     if (user != null) {
  //       loggedInUser = user;
  //     }
  //   } catch (e) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => const LoginOrRegisterPage(),
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meditate'),
      ),
      body: Column(
        children: [
          Center(
              child: CircularCountDownTimer(
            // Countdown duration in Seconds.
            duration: _duration,

            // Countdown initial elapsed Duration in Seconds.
            initialDuration: 0,

            // Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
            controller: _controller,

            // Width of the Countdown Widget.
            width: MediaQuery.of(context).size.width / 2,

            // Height of the Countdown Widget.
            height: MediaQuery.of(context).size.height / 2,

            // Ring Color for Countdown Widget.
            ringColor: Colors.grey[300]!,

            // Ring Gradient for Countdown Widget.
            ringGradient: null,

            // Filling Color for Countdown Widget.
            fillColor: Colors.purpleAccent[100]!,

            // Filling Gradient for Countdown Widget.
            fillGradient: null,

            // Background Color for Countdown Widget.
            backgroundColor: Colors.yellow[500],

            // Background Gradient for Countdown Widget.
            backgroundGradient: null,

            // Border Thickness of the Countdown Ring.
            strokeWidth: 20.0,

            // Begin and end contours with a flat edge and no extension.
            strokeCap: StrokeCap.round,

            // Text Style for Countdown Text.
            textStyle: const TextStyle(
              fontSize: 33.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),

            // Format for the Countdown Text.
            textFormat: CountdownTextFormat.S,

            // Handles Countdown Timer (true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)).
            isReverse: false,

            // Handles Animation Direction (true for Reverse Animation, false for Forward Animation).
            isReverseAnimation: false,

            // Handles visibility of the Countdown Text.
            isTimerTextShown: true,

            // Handles the timer start.
            autoStart: false,

            // This Callback will execute when the Countdown Starts.
            onStart: () {
              // Here, do whatever you want
              debugPrint('Countdown Started');
            },

            // This Callback will execute when the Countdown Ends.
            onComplete: () async {
              // Here, do whatever you want
              // var collection = _firestore
              //     .collection('userdata')
              //     .doc(loggedInUser!.email!)
              //     .collection('dailydata');
              // bool docExists = await checkIfDocExists(
              //     DateFormat('ddMMyyyy').format(DateTime.now()), collection);
              // if (docExists) {
              //   collection
              //       .doc(DateFormat('ddMMyyyy').format(DateTime.now()))
              //       .update({'isMedDone': true});
              // } else {
              //   collection
              //       .doc(DateFormat('ddMMyyyy').format(DateTime.now()))
              //       .set({'isMedDone': true}, SetOptions(merge: true));
              // }
            },
          )),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 30,
          ),
          _button(title: "Start", onPressed: () => _controller.start()),
          const SizedBox(
            width: 10,
          ),
          _button(title: "Pause", onPressed: () => _controller.pause()),
          const SizedBox(
            width: 10,
          ),
          _button(title: "Resume", onPressed: () => _controller.resume()),
          const SizedBox(
            width: 10,
          ),
          _button(
              title: "Restart",
              onPressed: () => _controller.restart(duration: _duration))
        ],
      ),
    );
  }

  Widget _button({required String title, VoidCallback? onPressed}) {
    return Expanded(
        child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.green),

      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: const TextStyle(color: Colors.white,fontSize: 8),
      ),
    ));
  }
}
