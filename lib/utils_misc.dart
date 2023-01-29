import 'package:flutter/material.dart';
import 'package:user_meals/user_meals/entities/resident.dart';

class UtilsMisc {
  static void onError(BuildContext context, String error) {
    final snackBar = SnackBar(
      content: Text(error),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Widget emptyWidget() {
    return Center(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text("沒有住民資料"),
            Text("點選\"+\"新增住民"),
          ],
        ),
      ),
    );
  }

  static String getBirthdayString(DateTime birthday) {
    return "${birthday.year.toString()}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}  ";
  }

  static Widget residentItemWidget(Resident resident) {
    final birthday =
        DateTime.fromMillisecondsSinceEpoch(resident.birthdayMillis());
    final birthdayString = getBirthdayString(birthday);
    return Row(
      children: [
        const Icon(Icons.person),
        Column(
          children: [
            Text(resident.name()),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '生日:$birthdayString',
                  textAlign: TextAlign.start,
                ),
                Text(
                  '年齡:${resident.age().toString()}',
                  textAlign: TextAlign.start,
                ),
              ],
            )
          ],
        ),
      ],
    );
  }

  static Future<void> showCreateResidentDialog(
      BuildContext context, Function onSavePressed,
      {name = "", age = 0, birthday = 0}) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          final nameController = TextEditingController(text: name);
          final birthdayController = TextEditingController(
              text: UtilsMisc.getBirthdayString(
                  DateTime.fromMillisecondsSinceEpoch(birthday)));
          final ageController = TextEditingController(text: "$age");
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
                  readOnly: true,
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1970),
                      lastDate: DateTime.now(),
                    ).then((value) {
                      birthday = value?.millisecondsSinceEpoch ?? 0;
                      if (value == null) {
                        birthdayController.text = "";
                      } else {
                        birthdayController.text =
                            UtilsMisc.getBirthdayString(value);
                      }
                      age = DateTime.now().year - (value ?? DateTime.now()).year;
                      ageController.text = age.toString();
                    });
                  },
                ),
                TextField(
                  controller: ageController,
                  readOnly: true,
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
                        onSavePressed(nameController.value.text, birthday, age);
                      },
                      child: const Text("儲存"),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}
