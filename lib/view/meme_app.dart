import 'package:flutter/material.dart';

import 'home_page.dart';

class MemeApp extends StatelessWidget {
  const MemeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.cyan),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
