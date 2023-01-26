import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  void _onCreateResidentPressed() {
    showCreateResidentDialog()
        .then((value) => setState(() {}))
        .onError((error, stackTrace) => null);
  }

  Widget _pageWidget() {
    switch (_currentPageIndex) {
      case indexPageMeal:
        return const MealPageWidget();
      case indexPageChart:
        return const ChartPageWidget();
      default:
        /* case INDEX_PAGE_USER */
        return const ResidentPageWidget();
    }
  }

  Future<void> showCreateResidentDialog() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          final nameController = TextEditingController();
          final birthdayController = TextEditingController();
          final ageController = TextEditingController();
          return Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("新增住民"),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "姓名"),
                ),
                TextField(
                  controller: birthdayController,
                  decoration: const InputDecoration(labelText: "生日"),
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1970),
                      lastDate: DateTime.now(),
                    ).then((value) {
                      birthdayController.text = value.toString();
                      ageController.text =
                          (DateTime.now().year - (value ?? DateTime.now()).year)
                              .toString();
                    });
                  },
                ),
                TextField(
                  controller: ageController,
                  decoration: const InputDecoration(labelText: "年齡"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("取消"),
                    ),
                    TextButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        CreateResident()
                            .execute(nameController.value.text, 0)
                            .then((value) => setState(() {}))
                            .onError(
                              (error, stackTrace) => UtilsMisc.onError(
                                context,
                                error.toString() + nameController.value.text,
                              ),
                            );
                      },
                      child: const Text("新增"),
                    ),
                  ],
                )
              ],
            ),
          );
        });
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
