import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:user_meals/landing_page.dart';
import 'package:user_meals/user_meals/UpdateResident.dart';
import 'package:user_meals/user_meals/create_resident.dart';
import 'package:user_meals/user_meals/delete_resident.dart';
import 'package:user_meals/user_meals/get_daily_meals.dart';
import 'package:user_meals/user_meals/get_resident.dart';
import 'package:user_meals/user_meals/get_total_breakfast_count.dart';
import 'package:user_meals/user_meals/get_total_dinner_count.dart';
import 'package:user_meals/user_meals/get_total_lunch_count.dart';
import 'package:user_meals/user_meals/repositories/repository_factory.dart';
import 'package:user_meals/user_meals/update_daily_meal.dart';

void main() {
  final storage = LocalStorage("stored.json");
  storage.getItem("residents");
  final repoFactory = RepositoryFactory(storage);
  runApp(UserMealApp(repoFactory));
  storage.dispose();
}

class UserMealApp extends StatelessWidget {
  final RepositoryFactory repoFactory;

  const UserMealApp(this.repoFactory, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final residentRepo = repoFactory.residentRepository();
    final dailyMealRepo = repoFactory.dailyMealsRepository();
    return MaterialApp(
      title: 'User meals',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(
        providers: [
          Provider<CreateResident>(
              create: (_) => CreateResident(residentRepo, dailyMealRepo)),
          Provider<GetResident>(create: (_) => GetResident(residentRepo)),
          Provider<GetDailyMeals>(create: (_) => GetDailyMeals(dailyMealRepo)),
          Provider<DeleteResident>(
              create: (_) => DeleteResident(residentRepo, dailyMealRepo)),
          Provider<UpdateDailyMeal>(
              create: (_) => UpdateDailyMeal(dailyMealRepo)),
          Provider<GetTotalBreakfastCount>(
              create: (_) => GetTotalBreakfastCount(dailyMealRepo)),
          Provider<GetTotalLunchCount>(
              create: (_) => GetTotalLunchCount(dailyMealRepo)),
          Provider<GetTotalDinnerCount>(
              create: (_) => GetTotalDinnerCount(dailyMealRepo)),
          Provider<UpdateDailyMeal>(
              create: (_) => UpdateDailyMeal(dailyMealRepo)),
          Provider<UpdateResident>(create: (_) => UpdateResident(residentRepo)),
        ],
        builder: (context, child) => const LandingPage(title: 'Resident meal'),
      ),
    );
  }
}
