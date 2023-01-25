import 'package:user_meals/user_meals/entities/resident.dart';

class GetResident {
  Future<List<Resident>> execute() {
    return Future.value([
      ConstResident(10, 1000, 1, "Name 1"),
      ConstResident(10, 1000, 2, "Name 2"),
      ConstResident(10, 1000, 3, "Name 3"),
      ConstResident(10, 1000, 4, "Name 4"),
      ConstResident(10, 1000, 5, "Name 5"),
      ConstResident(10, 1000, 6, "Name 6"),
      ConstResident(10, 1000, 7, "Name 7"),
    ]);
  }
}
