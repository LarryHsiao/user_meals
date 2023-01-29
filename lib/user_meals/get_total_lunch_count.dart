import 'dart:math';

import 'package:user_meals/user_meals/entities/daily_meal.dart';
import 'package:user_meals/user_meals/repositories/daily_meals_repository.dart';

class GetTotalLunchCount {
  final DailyMealsRepository repo;

  GetTotalLunchCount(this.repo);

  Future<int> execute() {
    return repo.getTotalLunchCount();
  }
}
