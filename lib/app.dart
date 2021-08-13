import 'package:cs492_project5/screens/new_entry.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/waste_entry_list.dart';
import 'screens/waste_entry.dart';
import 'screens/new_entry.dart';
  import 'screens/camera_screen.dart';

class MyApp extends StatefulWidget {
  static final routes = {
    WastefulEntriesScreen.routeName: (context) => WastefulEntriesScreen(),
    CameraScreen.routeName: (context) => CameraScreen(imageURL: ''),
  };

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late int totalWasted = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wasteagram',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      routes: MyApp.routes,
    );
  }

  void initState() {
    super.initState();
    totalWasted = 0;
    _totalWastedValue();
  }

  _totalWastedValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      totalWasted = prefs.getInt('totalWastedValue') ?? 0;
    });
  }

  Future addItems(int input) async {
    setState(() {
      totalWasted += input;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('totalWastedValue', totalWasted);
  }
}