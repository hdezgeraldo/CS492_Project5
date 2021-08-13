class FoodWastePost {
  late DateTime date;
  late String photoURL;
  late int quantity;
  late double latitude;
  late double longitude;

  FoodWastePost({required this.date, required this.photoURL, required this.quantity, required this.latitude, required this.longitude});

  FoodWastePost.fromMap(Map<dynamic, dynamic> data) {
    this.date = data['date'];
    this.photoURL = data['photoURL'];
    this.quantity = data['quantity'];
    this.longitude = data['longitude'];
    this.latitude = data['latitude'];
  }
}