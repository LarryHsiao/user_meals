import 'package:user_meals/user_meals/repositories/resident_repository.dart';

class UpdateResident {
  final ResidentRepository repo;

  UpdateResident(this.repo);

  Future<void> execute(int id, String name, int birthday, int age) async {
    return repo.updateResident(id, name, birthday, age);
  }
}
