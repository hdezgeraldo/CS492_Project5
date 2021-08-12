import 'package:flutter/material.dart';
import 'waste_entry.dart';
import 'camera_screen.dart';
import 'remote_data_screen.dart';
import 'share_location_screen.dart';
import '../models/wastegram.dart';

class WastefulEntriesScreen extends StatefulWidget {
  static const routeName = "/";

  @override
  _WastefulEntriesScreenState createState() => _WastefulEntriesScreenState();
}

class _WastefulEntriesScreenState extends State<WastefulEntriesScreen> {

  late Wastegram wastegram;

  @override
  void initState() {
    super.initState();
    wastegram = Wastegram.fake();
  }

  void loadGram() async {
    // print(wastegram);
  }

  Widget build(BuildContext context) {
    if(wastegram.isEmpty){
      return Scaffold(
          appBar: AppBar(
            title: Text('Wastegram - #'),
          ),
          body: loading()
      );
    } else {
      return Scaffold(
          appBar: AppBar(
            title: Text('Wastegram - #'),
          ),
          body: wasteListBuilder(context),
          floatingActionButton: FloatingActionButton(
            foregroundColor: Colors.black,
            backgroundColor: Colors.cyan[600],
            child: Icon(Icons.camera_alt),
            onPressed: () {
              Navigator.of(context).pushNamed(CameraScreen.routeName);
            },
          ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    }
  }

  Widget loading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator()
        ]
      )
    );
  }

  Widget wasteListBuilder(BuildContext context) {
    return ListView.builder(
      itemCount: wastegram.entries.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('${wastegram.entries[index].date}'),
          trailing: Text('${wastegram.entries[index].numberItems}'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShareLocationScreen()
              )
            );
          },
        );
      },
    );
  }
}