import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:user_meals/user_meals/entities/daily_meal.dart';
import 'package:user_meals/user_meals/get_total_breakfast_count.dart';
import 'package:user_meals/user_meals/get_total_dinner_count.dart';
import 'package:user_meals/user_meals/get_total_lunch_count.dart';

class ChartPageWidget extends StatefulWidget {
  const ChartPageWidget({Key? key}) : super(key: key);

  @override
  State createState() => _ChartPageWidgetState();
}

class _ChartPageWidgetState extends State<ChartPageWidget> {
  int _breakfastCount = 0;
  int _lunchCount = 0;
  int _dinnerCount = 0;

  @override
  void initState() {
    super.initState();
    GetTotalBreakfastCount()
        .execute()
        .then((value) => _breakfastCount = value)
        .whenComplete(() => setState(() {}));
    GetTotalLunchCount()
        .execute()
        .then((value) => _lunchCount = value)
        .whenComplete(() => setState(() {}));
    GetTotalDinnerCount()
        .execute()
        .then((value) => _dinnerCount = value)
        .whenComplete(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("早餐: $_breakfastCount"),
        Text("中餐: $_lunchCount"),
        Text("晚餐: $_dinnerCount"),
      ],
    );
  }
}
