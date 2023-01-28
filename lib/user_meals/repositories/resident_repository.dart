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

  StoredResidentRepository(this.storage);

  @override
  Future<int> createResident(String name, int birthdayMillis, int age) async {
    final residents = await getResidents();
    final residentMap = {
      for (var resident in residents) resident.id(): resident
    };
    var id = 1;
    if (residentMap.isNotEmpty) {
      id = residentMap.keys.reduce(max) + 1;
    }
    residentMap[id] = ConstResident(age, birthdayMillis, id, name);
    _save(residentMap.values.toList());
    return Future(() => id);
  }

  @override
  Future<void> deleteResident(int id) async {
    final residents = await getResidents();
    residents.removeWhere((element) => element.id() == id);
    _save(residents);
  }

  void _save(List<Resident> residents) {
    storage.setItem(keyResidents, residents.map((e) {
      Map<String, dynamic> map = {};
      map[keyResidentId] = e.id();
      map[keyResidentAge] = e.age();
      map[keyResidentMillis] = e.birthdayMillis();
      map[keyResidentName] = e.name();
      return map;
    }).toList());
  }

  @override
  Future<List<Resident>> getResidents() {
    final rawItems = storage.getItem(keyResidents) ?? [];
    final items = (rawItems as List).map((e) {
      return ConstResident(
        e[keyResidentAge],
        e[keyResidentMillis],
        e[keyResidentId],
        e[keyResidentName],
      );
    }).toList();
    return Future.value(items);
  }
}
