
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/food_waste_post.dart';

class SingleEntry extends StatelessWidget {
  final FoodWastePost entry;
  const SingleEntry({Key? key, required this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                formatDate(entry.date),
                style: Theme.of(context).textTheme.headline6
              ),
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: 500.0,
                  width: 250.0,
                  child: Image.network('${entry.photoURL}'))
            ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  '${entry.quantity} item(s)',
                  style: Theme.of(context).textTheme.headline5
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  'location(${entry.longitude}, ${entry.latitude})',
                  style: Theme.of(context).textTheme.headline5
              ),
            ],
          ),
        ],

      ),
    );
  }

  String formatDate(DateTime date){
    return DateFormat('EEEE, MMM d, yyyy').format(date);
  }
}