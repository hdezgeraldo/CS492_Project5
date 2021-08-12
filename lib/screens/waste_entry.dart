import 'package:flutter/material.dart';

class WasteEntryScreen extends StatelessWidget {
  static const routeName = 'waste_screen';

  const WasteEntryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Wastegram'),
        )
    );
  }
}
