import 'package:dictionary_application/screens/splash_scrren.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const Dictionaryapp());
}

class Dictionaryapp extends StatelessWidget {
  const Dictionaryapp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
