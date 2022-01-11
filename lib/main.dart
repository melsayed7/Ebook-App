import 'package:ebook_app/audio_screen.dart';
import 'package:flutter/material.dart';

import 'ebook_scrren.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EBookScreen(),
    );
  }
}


