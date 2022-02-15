import 'package:flutt/main3.dart';
import 'package:flutter/material.dart';
import 'package:unity_ads_plugin/unity_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // UnityAds.init(
  //   gameId: '4608602',
  //  // testMode: true,
  // );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: main3(),
      debugShowCheckedModeBanner: false,
    );
  }
}
