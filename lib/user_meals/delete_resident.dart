import 'package:user_meals/user_meals/repositories/daily_meals_repository.dart';
import 'package:user_meals/user_meals/repositories/resident_repository.dart';

class DeleteResident {
  final ResidentRepository repo;
  final DailyMealsRepository dailyMealsRepository;

  DeleteResident(this.repo, this.dailyMealsRepository);

  Future<void> execute(int id) {
    return repo.deleteResident(id).then((value) async {
      await dailyMealsRepository.deleteDailyMealByResidentId(id);
    });
  }
}
