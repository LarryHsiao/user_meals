import 'package:user_meals/user_meals/entities/daily_meal.dart';

class DailyMealsRepository {
  Future<List<DailyMeal>> getDailyMeals() {
    return Future(() => List.empty());
  }

  Future<void> updateDailyMeal(DailyMeal dailyMeal) {
    return Future.value(null);
  }

  Future<int> getTotalBreakfastCount() {
    return Future.value(0);
  }

  Future<int> getTotalLunchCount() {
    return Future.value(0);
  }

  Future<int> getTotalDinnerCount() {
    return Future.value(0);
  }
}
