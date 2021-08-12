import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/character.dart';

class RemoteDataScreen extends StatefulWidget {
  static const routeName = 'remote_data';
  static const URL = 'https://swapi.dev/api/people/2';

  @override
  _RemoteDataScreenState createState() => _RemoteDataScreenState();
}

class _RemoteDataScreenState extends State<RemoteDataScreen> {

  Future<http.Response> apiResponse = http.get(Uri.parse(RemoteDataScreen.URL));

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: apiResponse,
      builder: (context, AsyncSnapshot snapshot) {
        Widget child;
        if(snapshot.hasData){
          Character character = Character.fromJSON(jsonDecode(snapshot.data.body));
          child = Text('${character.name}');
        } else {
          child = CircularProgressIndicator();
        }
        return Center(child: child);
      }
    );
  }
}
