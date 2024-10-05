import 'package:dictionary_application/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      navigatetohomescreen();
    });
  }

  void navigatetohomescreen() {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => HomeScreen()), (Route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/dictionary.jpg'),
          const Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
