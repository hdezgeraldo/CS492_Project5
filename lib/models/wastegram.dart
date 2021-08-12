import 'wastegram_entry.dart';

class Wastegram {
  late List<WastegramEntry> entries;

  Wastegram({required this.entries});

  Wastegram.fake() {
    entries = [
      WastegramEntry(date: DateTime.now(), numberItems: 2)
    ];
  }

  bool get isEmpty => entries.isEmpty;
}