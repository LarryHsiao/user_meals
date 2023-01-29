import 'package:localstorage/localstorage.dart';
import 'package:user_meals/user_meals/repositories/daily_meals_repository.dart';
import 'package:user_meals/user_meals/repositories/resident_repository.dart';

class RepositoryFactory {
  final LocalStorage _storage;
  ResidentRepository? _residentRepo;
  DailyMealsRepository? _dailyMealsRepo;

  RepositoryFactory(this._storage);

  DailyMealsRepository dailyMealsRepository() {
    _dailyMealsRepo ??= StoredDailyMealsRepository(_storage);
    return _dailyMealsRepo!;
  }

  ResidentRepository residentRepository() {
    _residentRepo ??= StoredResidentRepository(_storage);
    return _residentRepo!;
  }
}
