import 'package:flutter/material.dart';
import 'new.dart';
import 'video.dart';

main() {
  runApp(
    MaterialApp(
      initialRoute: "/new",
      routes: {
        "/new": (context) => MyApp(),
        "/video": (context) => VideoApp(),
      },
    ),
  );
}
