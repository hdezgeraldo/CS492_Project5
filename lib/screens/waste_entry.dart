import 'package:flutter/material.dart';
import '../models/food_waste_post.dart';
import '../widgets/single_entry.dart';

class WasteEntryScreen extends StatelessWidget {
  static const routeName = 'waste_screen';
  final FoodWastePost entry;
  const WasteEntryScreen({Key? key, required this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Wastegram'),
        ),
        body: SingleEntry(entry: entry)
    );
  }
}
