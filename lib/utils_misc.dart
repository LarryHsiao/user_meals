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

  static Widget residentItemWidget(Resident resident) {
    final birthday =
        DateTime.fromMicrosecondsSinceEpoch(resident.birthdayMillis());
    final birthdayString =
        "${birthday.year.toString()}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}  ";
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
}
