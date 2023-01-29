import 'package:user_meals/user_meals/repositories/resident_repository.dart';

class DeleteResident {
  final ResidentRepository repo;

  DeleteResident(this.repo);

  Future<void> execute(int id) {
    return repo.deleteResident(id);
  }
}
