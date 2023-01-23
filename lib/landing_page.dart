import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:user_meals/chart_page.dart';
import 'package:user_meals/meal_page.dart';
import 'package:user_meals/person_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  static const int INDEX_PAGE_USER = 0;
  static const int INDEX_PAGE_MEAL = 1;
  static const int INDEX_PAGE_CHART = 2;

  var _currentPageIndex = INDEX_PAGE_USER;

  void _incrementCounter() {
    setState(() {});
  }

  Widget _pageWidget() {
    switch (_currentPageIndex) {
      case INDEX_PAGE_MEAL:
        return const MealPageWidget();
      case INDEX_PAGE_CHART:
        return const ChartPageWidget();
      default:
        /* case INDEX_PAGE_USER */
        return const PersonPageWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: _pageWidget(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '註冊',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "供餐",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: "統計")
        ],
        currentIndex: _currentPageIndex,
        onTap: (idx) {
          setState(() {
            _currentPageIndex = idx;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
