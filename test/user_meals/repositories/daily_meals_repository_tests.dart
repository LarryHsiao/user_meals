// @dart=2.9 todo: Waiting for dependencies update.
import 'package:localstorage/localstorage.dart';
import 'package:test/test.dart';
import 'package:user_meals/user_meals/entities/daily_meal.dart';
import 'package:user_meals/user_meals/repositories/daily_meals_repository.dart';

void main() {
  final storage = LocalStorage("temp.json");
  final repo = StoredDailyMealsRepository(storage);
  test(
    "No meals at first",
    () async {
      await storage.clear();
      final result = await repo.getDailyMeals();
      expect(result.isEmpty, equals(true));
    },
  );

  test(
    "Can create meals",
    () async {
      final id = await repo.createDailyMeals(false, false, false, 1);
      final result = await repo.getDailyMealById(id);
      expect(result.id(), equals(id));
    },
  );

  test(
    "Can update meals",
    () async {
      final id = await repo.createDailyMeals(false, false, false, 1);
      await repo.updateDailyMeal(ConstDailyMeal(true, true, id, true, 2));
      final result = await repo.getDailyMealById(id);
      expect(result.breakfast(), true);
      expect(result.lunch(), true);
      expect(result.dinner(), true);
      expect(result.residentId(), 2);
    },
  );

  test(
    "Count of meals.",
    () async {
      // Due to the entry has been created, assert the counters.
      expect(await repo.getTotalBreakfastCount(), 1);
      expect(await repo.getTotalLunchCount(), 1);
      expect(await repo.getTotalDinnerCount(), 1);
    },
  );
}
