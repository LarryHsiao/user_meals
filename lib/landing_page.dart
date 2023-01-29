import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:user_meals/chart_page.dart';
import 'package:user_meals/meal_page.dart';
import 'package:user_meals/resident_page.dart';
import 'package:user_meals/user_meals/create_resident.dart';
import 'package:user_meals/utils_misc.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  static const int indexPageUser = 0;
  static const int indexPageMeal = 1;
  static const int indexPageChart = 2;

  var _currentPageIndex = indexPageUser;
  int userAction = 0;

  void _onCreateResidentPressed() {
    UtilsMisc.showCreateResidentDialog(context, (
      String name,
      int birthday,
      int age,
    ) {
      Provider.of<CreateResident>(context, listen: false)
          .execute(name, birthday, age)
          .then((value) {
        setState(() {
          userAction++;
        });
      }).onError((error, stackTrace) {
        UtilsMisc.onError(
          context,
          error.toString() + name,
        );
      });
    }).then((value) => setState(() {})).onError((error, stackTrace) => null);
  }

  Widget _pageWidget() {
    switch (_currentPageIndex) {
      case indexPageMeal:
        return MealPageWidget(key: Key(userAction.toString()));
      case indexPageChart:
        return ChartPageWidget(key: Key(userAction.toString()));
      default:
        /* case INDEX_PAGE_USER */
        return ResidentPageWidget(key: Key(userAction.toString()));
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
        onPressed: _onCreateResidentPressed,
        tooltip: 'New resident',
        child: const Icon(Icons.add),
      ),
    );
  }
}
