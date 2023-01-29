import 'package:user_meals/user_meals/entities/daily_meal.dart';
import 'package:user_meals/user_meals/entities/resident.dart';
import 'package:user_meals/user_meals/repositories/daily_meals_repository.dart';
import 'package:user_meals/user_meals/repositories/resident_repository.dart';

class GetDailyMeals {
  final DailyMealsRepository repo;

  GetDailyMeals(this.repo);

  Future<List<DailyMeal>> execute() {
    return repo.getDailyMeals();
  }
}
