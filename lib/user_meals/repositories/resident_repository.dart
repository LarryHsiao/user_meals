import 'dart:math';

import 'package:localstorage/localstorage.dart';
import 'package:user_meals/user_meals/entities/resident.dart';

class ResidentRepository {
  Future<int> createResident(String name, int birthdayMillis, int age) {
    return Future.value(-1);
  }

  Future<void> deleteResident(int id) {
    return Future.value(null);
  }

  Future<List<Resident>> getResidents() {
    return Future.value(List.empty());
  }
}

class StoredResidentRepository implements ResidentRepository {
  static const String keyResidents = "residents";
  static const String keyResidentId = "id";
  static const String keyResidentAge = "age";
  static const String keyResidentMillis = "millis";
  static const String keyResidentName = "name";
  final LocalStorage storage;
  final Map<int, Resident> memoryResidents = {};

  StoredResidentRepository(this.storage);

  @override
  Future<int> createResident(String name, int birthdayMillis, int age) async {
    await getResidents();
    var id = 1;
    if (memoryResidents.isNotEmpty) {
      id = memoryResidents.keys.reduce(max) + 1;
    }
    memoryResidents[id] = ConstResident(age, birthdayMillis, id, name);
    await _save();
    return Future(() => id);
  }

  @override
  Future<void> deleteResident(int id) async {
    await getResidents();
    memoryResidents.remove(id);
    await _save();
  }

  Future<void> _save() async {
    final List<Map<String, dynamic>> json = memoryResidents.values.map((e) {
      Map<String, dynamic> map = {};
      map[keyResidentId] = e.id();
      map[keyResidentAge] = e.age();
      map[keyResidentMillis] = e.birthdayMillis();
      map[keyResidentName] = e.name();
      return map;
    }).toList();
    await storage.setItem(keyResidents, json);
  }

  @override
  Future<List<Resident>> getResidents() {
    if (memoryResidents.isEmpty) {
      final rawItems = storage.getItem(keyResidents) ?? [];
      final items = (rawItems as List).map((e) {
        return ConstResident(
          e[keyResidentAge],
          e[keyResidentMillis],
          e[keyResidentId],
          e[keyResidentName],
        );
      }).toList();
      memoryResidents.addAll({for (var item in items) item.id(): item});
    }
    return Future.value(memoryResidents.values.toList());
  }
}
