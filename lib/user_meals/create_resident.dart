import 'package:user_meals/user_meals/repositories/daily_meals_repository.dart';
import 'package:user_meals/user_meals/repositories/resident_repository.dart';

class CreateResident {
  final ResidentRepository repo;
  final DailyMealsRepository dailyMealsRepository;

  CreateResident(this.repo, this.dailyMealsRepository);

  Future<int> execute(String name, int birthday, age) {
    return repo.createResident(name, birthday, age).then((value) async{
      await dailyMealsRepository.createDailyMeals(false, false, false, value);
      return value;
    });
  }
}
