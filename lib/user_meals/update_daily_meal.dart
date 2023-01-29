import 'package:user_meals/user_meals/entities/daily_meal.dart';
import 'package:user_meals/user_meals/repositories/daily_meals_repository.dart';

class UpdateDailyMeal {
  final DailyMealsRepository repo;

  UpdateDailyMeal(this.repo);

  Future<void> execute(DailyMeal dailyMeal) {
    return repo.updateDailyMeal(dailyMeal);
  }
}
