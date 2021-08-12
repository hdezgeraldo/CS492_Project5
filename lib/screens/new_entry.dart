import 'package:flutter/material.dart';

class NewEntryScreen extends StatefulWidget {
  static const routeName = 'new_entry';

  const NewEntryScreen({Key? key}) : super(key: key);

  @override
  _NewEntryScreenState createState() => _NewEntryScreenState();
}

class _NewEntryScreenState extends State<NewEntryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wastegram'),
      ),
    );
  }
}
