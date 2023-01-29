import 'package:user_meals/user_meals/entities/resident.dart';
import 'package:user_meals/user_meals/repositories/resident_repository.dart';

class GetResident {
  final ResidentRepository repo;

  GetResident(this.repo);

  Future<List<Resident>> execute() {
    return repo.getResidents();
  }
}
