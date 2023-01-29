import 'dart:math';

import 'package:collection/collection.dart';
import 'package:localstorage/localstorage.dart';
import 'package:user_meals/user_meals/entities/daily_meal.dart';

class DailyMealsRepository {
  Future<List<DailyMeal>> getDailyMeals() {
    return Future(() => List.empty());
  }

  Future<int> createDailyMeals(
    bool breakfast,
    bool lunch,
    bool dinner,
    int residentId,
  ) {
    return Future.value(-1);
  }

  Future<DailyMeal> getDailyMealById(int id) {
    return Future.error("Id of DailyMeal not found: $id");
  }

  Future<void> updateDailyMeal(DailyMeal dailyMeal) {
    return Future.value(null);
  }

  Future<void> deleteDailyMealByResidentId(int id) {
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

class StoredDailyMealsRepository implements DailyMealsRepository {
  static const String keyDailyMeals = 'daily_meals';
  static const String keyDailyMealFieldId = 'id';
  static const String keyDailyMealFieldLunch = 'lunch';
  static const String keyDailyMealFieldBreakfast = 'breakfast';
  static const String keyDailyMealFieldDinner = 'dinner';
  static const String keyDailyMealFieldResidentId = 'residentId';

  final LocalStorage storage;

  StoredDailyMealsRepository(this.storage);

  @override
  Future<List<DailyMeal>> getDailyMeals() {
    final rawMeals = storage.getItem(keyDailyMeals) ?? [];
    final List<DailyMeal> meals = (rawMeals as List)
        .map((e) => ConstDailyMeal(
              e[keyDailyMealFieldBreakfast],
              e[keyDailyMealFieldDinner],
              e[keyDailyMealFieldId],
              e[keyDailyMealFieldLunch],
              e[keyDailyMealFieldResidentId],
            ))
        .toList();
    return Future.value(meals);
  }

  @override
  Future<int> getTotalBreakfastCount() async {
    final meals = await getDailyMeals();
    return Future.value(meals.map((e) {
      if (e.breakfast()) {
        return 1;
      } else {
        return 0;
      }
    }).sum);
  }

  @override
  Future<int> getTotalDinnerCount() async {
    final meals = await getDailyMeals();
    return Future.value(meals.map((e) {
      if (e.dinner()) {
        return 1;
      } else {
        return 0;
      }
    }).sum);
  }

  @override
  Future<int> getTotalLunchCount() async {
    final meals = await getDailyMeals();
    return Future.value(meals.map((e) {
      if (e.lunch()) {
        return 1;
      } else {
        return 0;
      }
    }).sum);
  }

  @override
  Future<void> updateDailyMeal(DailyMeal dailyMeal) async {
    final meals = (await getDailyMeals());
    final mealsMap = {for (var item in meals) item.id(): item};
    if (mealsMap.containsKey(dailyMeal.id())) {
      mealsMap.addEntries([MapEntry(dailyMeal.id(), dailyMeal)]);
      _save(mealsMap);
    } else {
      return Future.error("Id of DailyMeal not found:${dailyMeal.id()}");
    }
  }

  void _save(Map<int, DailyMeal> mealsMap) {
    final mealsJson = mealsMap.values.toList().map((e) {
      final Map<String, dynamic> map = {};
      map[keyDailyMealFieldId] = e.id();
      map[keyDailyMealFieldLunch] = e.lunch();
      map[keyDailyMealFieldBreakfast] = e.breakfast();
      map[keyDailyMealFieldDinner] = e.dinner();
      map[keyDailyMealFieldResidentId] = e.residentId();
      return map;
    }).toList();
    storage.setItem(keyDailyMeals, mealsJson);
  }

  @override
  Future<int> createDailyMeals(
    bool breakfast,
    bool lunch,
    bool dinner,
    int residentId,
  ) async {
    final meals = await getDailyMeals();
    final mealsMap = {for (var entry in meals) entry.id(): entry};
    final int newId;
    if (mealsMap.isNotEmpty) {
      newId = meals.map((e) => e.id()).reduce(max) + 1;
    } else {
      newId = 1;
    }
    mealsMap[newId] =
        ConstDailyMeal(breakfast, dinner, newId, lunch, residentId);
    _save(mealsMap);
    return Future(() => newId);
  }

  @override
  Future<DailyMeal> getDailyMealById(int id) async {
    final meals = await getDailyMeals();
    final mealsMap = {for (var entry in meals) entry.id(): entry};
    if (mealsMap.containsKey(id)) {
      return Future.value(mealsMap[id] ??
          ConstDailyMeal(false, false, -1, false,
              -1)); // Return ConstDailyMeal for null safety.
    } else {
      return Future.error("Id of DailyMeal not exist: $id");
    }
  }

  @override
  Future<void> deleteDailyMealByResidentId(int residentId) async {
    final meals = await getDailyMeals();
    meals.removeWhere((element) => element.residentId() == residentId);
    final mealsMap = {for (var entry in meals) entry.id(): entry};
    _save(mealsMap);
    return Future.value(null);
  }
}
