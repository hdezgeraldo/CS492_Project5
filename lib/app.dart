import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:sentry/sentry.dart';
import 'screens/waste_entry_list.dart';
import 'screens/camera_screen.dart';

class MyApp extends StatefulWidget {

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late int totalWasted = 0;
  static Future<void> reportError(dynamic error, dynamic stackTrace) async {
    final sentryId =
    await Sentry.captureException(error, stackTrace: stackTrace);
  }
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wasteagram',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      navigatorObservers: <NavigatorObserver>[observer],
      routes: {
        WastefulEntriesScreen.routeName: (context) => WastefulEntriesScreen(
            analytics: analytics,
            observer: observer
        ),
        CameraScreen.routeName: (context) => CameraScreen(imageURL: ''),
      },
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