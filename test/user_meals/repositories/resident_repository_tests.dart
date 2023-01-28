// @dart=2.9 todo: Figure out the correct solution.
import 'package:localstorage/localstorage.dart';
import 'package:test/test.dart';
import 'package:user_meals/user_meals/repositories/resident_repository.dart';

void main() {
  final storage = LocalStorage("temp.json");
  storage.clear();
  final repo = StoredResidentRepository(storage);
  test(
    "No residents at first",
        () async {
      final result = await repo.getResidents();
      expect(result.isEmpty, equals(true));
    },
  );
  test(
    "New resident",
        () async {
      final createdId = await repo.createResident("name", 0, 10);
      expect(createdId, equals(1));
    },
  );
  test(
    "Delete resident",
        () async {
      await repo.deleteResident(1);
      final residents = await repo.getResidents();
      expect(residents.isEmpty, equals(true));
    },
  );
  storage.clear();
}
