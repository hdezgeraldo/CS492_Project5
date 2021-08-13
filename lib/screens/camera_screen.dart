import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import '../app.dart';
import 'waste_entry_list.dart';

class CameraScreen extends StatefulWidget {
  static const routeName = 'camera_screen';
  final String imageURL;

  const CameraScreen({Key? key, required this.imageURL}) : super(key: key);


  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? image;
  String? imageUrl;
  LocationData? locationData;
  var locationService = Location();
  late int formInput;
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    image = File(pickedFile!.path);

    var fileName = DateTime.now().toString() + '.jpg';
    Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = storageReference.putFile(image!);
    await uploadTask;
    final url = await storageReference.getDownloadURL();
    return url;
  }

  @override
  void initState() {
    super.initState();
    loadImage();
    retrieveLocation();
  }

  void loadImage() async {
    final url = await getImage();
    setState(() {
      imageUrl = url;
    });
  }

  void retrieveLocation() async {
    try {
      var _serviceEnabled = await locationService.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await locationService.requestService();
        if (!_serviceEnabled) {
          print('Failed to enable service. Returning.');
          return;
        }
      }

      var _permissionGranted = await locationService.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await locationService.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          print('Location service permission not granted. Returning.');
        }
      }

      locationData = await locationService.getLocation();
    } on PlatformException catch (e) {
      print('Error: ${e.toString()}, code: ${e.code}');
      locationData = null;
    }
    locationData = await locationService.getLocation();
    setState(() {});
  }

  Widget build(BuildContext context) {
    MyAppState? appState = context.findAncestorStateOfType<MyAppState>();

    if(imageUrl == null) {
      return Scaffold(
        appBar: AppBar(title: Text('hello')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: CircularProgressIndicator()),
          ],
        )
      );
    } else {
      return Scaffold(
          appBar: AppBar(title: Text('hello')),
          body: Container(
              child: Column(
                children: [
                  Image.network('$imageUrl'),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.phone,
                          onSaved: (value) {
                            if (value!.isNotEmpty) {
                              formInput = int.parse(value);
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a number';
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: ElevatedButton(
                            onPressed: () {
                              _formKey.currentState!.save();
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  if(appState != null) {
                                    appState.addItems(formInput);
                                  }
                                });
                                uploadData(formInput);
                                Navigator.of(context).popAndPushNamed(WastefulEntriesScreen.routeName);
                              }
                            },
                            child: const Text('Submit'),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
          )
      );
    }
  }

  void uploadData(int input) async {
    final latitude = locationData!.latitude;
    final longitude = locationData!.longitude;
    final time = Timestamp.now();
    final number = input;
    FirebaseFirestore.instance
        .collection('posts')
        .add({'food_items': number, 'submission_date': time, 'url': imageUrl, 'latitude': latitude, 'longitude': longitude});
  }
}
