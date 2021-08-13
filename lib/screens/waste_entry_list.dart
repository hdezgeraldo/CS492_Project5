import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'waste_entry.dart';
import 'camera_screen.dart';
import '../models/food_waste_post.dart';

class WastefulEntriesScreen extends StatefulWidget {
  static const routeName = "/";

  @override
  WastefulEntriesScreenState createState() => WastefulEntriesScreenState();
}

class WastefulEntriesScreenState extends State<WastefulEntriesScreen> {
  late int totalWasted = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wasteagram - $totalWasted')),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData &&
                snapshot.data!.docs != null &&
                snapshot.data!.docs.length > 0) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var post = snapshot.data!.docs[index];
                        return ListTile(
                            leading: Text(
                              formatDate(post['submission_date']),
                              textAlign: TextAlign.left,
                            ),
                            title: Text(
                              post['food_items'].toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5,
                              textAlign: TextAlign.right,
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WasteEntryScreen(
                                          entry: FoodWastePost.fromMap({
                                            'date': post['submission_date']
                                                .toDate(),
                                            'photoURL': post['url'],
                                            'quantity': post['food_items'],
                                            'longitude': post['longitude'],
                                            'latitude': post['latitude'],
                                          })
                                      )
                                  )
                              );
                            },
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: CircularProgressIndicator()),
                ],
              );
            }
      }),
      floatingActionButton: Semantics(
        button: true,
        enabled: true,
        onTapHint: 'Select an image',
        child: FloatingActionButton(
          foregroundColor: Colors.black,
          backgroundColor: Colors.cyan[600],
          child: Icon(Icons.camera_alt),
          onPressed: () {
            Navigator.of(context).pushNamed(CameraScreen.routeName);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  String formatDate(Timestamp date){
    DateTime dt = date.toDate();
    return DateFormat('EEEE, MMM d, yyyy').format(dt);
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
}