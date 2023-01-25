import 'dart:math';

import 'package:user_meals/user_meals/entities/daily_meal.dart';

class GetTotalLunchCount {
  Future<int> execute() {
    return Future.value(Random.secure().nextInt(10));
  }
}
