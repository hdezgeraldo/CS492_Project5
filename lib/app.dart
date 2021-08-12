import 'package:cs492_project5/screens/new_entry.dart';
import 'package:cs492_project5/screens/remote_data_screen.dart';
import 'package:flutter/material.dart';
import 'screens/waste_entry_list.dart';
import 'screens/waste_entry.dart';
import 'screens/new_entry.dart';
import 'screens/share_location_screen.dart';
import 'screens/camera_screen.dart';

class MyApp extends StatefulWidget {
  static final routes = {
    WastefulEntriesScreen.routeName: (context) => WastefulEntriesScreen(),
    WasteEntryScreen.routeName: (context) => WasteEntryScreen(),
    NewEntryScreen.routeName: (context) => NewEntryScreen(),
    ShareLocationScreen.routeName: (context) => ShareLocationScreen(),
    CameraScreen.routeName: (context) => CameraScreen(),
    RemoteDataScreen.routeName: (context) => RemoteDataScreen()
  };

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
}