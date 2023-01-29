import 'package:localstorage/localstorage.dart';
import 'package:user_meals/user_meals/repositories/daily_meals_repository.dart';
import 'package:user_meals/user_meals/repositories/resident_repository.dart';

class RepositoryFactory {
  final LocalStorage storage;

  RepositoryFactory(this.storage);

  DailyMealsRepository dailyMealsRepository() {
    return StoredDailyMealsRepository(storage);
  }

  ResidentRepository residentRepository() {
    return StoredResidentRepository(storage);
  }
}
