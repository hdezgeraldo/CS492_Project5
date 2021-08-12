class Character {
  final String name;
  final int height;
  final String gender;

  Character({required this.name, required this.height, required this.gender});

  factory Character.fromJSON(Map<String, dynamic> json) {
    return Character(
        name: json['name'],
        height: int.parse(json['height']),
        gender: json['gender']);
  }
}
