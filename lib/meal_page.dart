import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_meals/user_meals/entities/daily_meal.dart';
import 'package:user_meals/user_meals/entities/resident.dart';
import 'package:user_meals/user_meals/get_daily_meals.dart';
import 'package:user_meals/user_meals/get_resident.dart';
import 'package:user_meals/user_meals/repositories/resident_repository.dart';
import 'package:user_meals/user_meals/update_daily_meal.dart';
import 'package:user_meals/utils_misc.dart';

class MealPageWidget extends StatefulWidget {
  const MealPageWidget({Key? key}) : super(key: key);

  @override
  State createState() => _MealPageWidgetState();
}

class _MealPageWidgetState extends State<MealPageWidget> {
  final _residents = <Resident>[];
  final _meals = <int, DailyMeal>{};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GetResident>(context, listen: false).execute().then((value) {
        _residents.addAll(value);
        setState(() {});
      }).onError((error, stackTrace) {
        UtilsMisc.onError(context, error.toString());
      });
      Provider.of<GetDailyMeals>(context, listen: false)
          .execute()
          .then((value) {
        _meals.addAll({for (var e in value) e.residentId(): e});
        setState(() {});
      }).onError((error, stackTrace) {
        UtilsMisc.onError(context, error.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_residents.isEmpty) {
      return UtilsMisc.emptyWidget();
    } else {
      return _mealsWidget();
    }
  }

  Widget _mealsWidget() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: _residents.length,
      itemBuilder: (context, idx) => _itemWidget(_residents[idx]),
    );
  }

  void _updateMeal(DailyMeal meal) {
    Provider.of<UpdateDailyMeal>(context, listen: false)
        .execute(meal)
        .then((value) => setState(() {
              _meals[meal.residentId()] = meal;
            }))
        .onError((error, stackTrace) =>
            UtilsMisc.onError(context, error.toString()));
  }

  Widget _itemWidget(Resident resident) {
    final dailyMeal = _meals[resident.id()] ??
        ConstDailyMeal(false, false, -1, false, resident.id());
    return Card(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            UtilsMisc.residentItemWidget(resident),
            Row(children: [
              const Text("??????"),
              Checkbox(
                value: dailyMeal.breakfast(),
                onChanged: (newValue) {
                  _updateMeal(UpdatedDailyMeal(
                    dailyMeal,
                    newValue,
                    null,
                    null,
                  ));
                },
              ),
              const Text("??????"),
              Checkbox(
                value: dailyMeal.lunch(),
                onChanged: (newValue) {
                  _updateMeal(UpdatedDailyMeal(
                    dailyMeal,
                    null,
                    newValue,
                    null,
                  ));
                },
              ),
              const Text("??????"),
              Checkbox(
                value: dailyMeal.dinner(),
                onChanged: (newValue) {
                  _updateMeal(UpdatedDailyMeal(
                    dailyMeal,
                    null,
                    null,
                    newValue,
                  ));
                },
              ),
              const Text("??????"),
            ]),
          ],
        ),
      ),
    );
  }
}
