import 'package:flutter/material.dart';
import 'package:user_meals/user_meals/entities/resident.dart';
import 'package:user_meals/user_meals/get_resident.dart';
import 'package:user_meals/utils_misc.dart';

class ResidentPageWidget extends StatefulWidget {
  const ResidentPageWidget({Key? key}) : super(key: key);

  @override
  State createState() => _ResidentPageWidgetState();
}

class _ResidentPageWidgetState extends State<ResidentPageWidget> {
  final _residents = <Resident>[];

  @override
  void initState() {
    super.initState();
    GetResident()
        .execute()
        .then((value) => setState(() {
              _residents.addAll(value);
            }))
        .onError(
      (error, stackTrace) {
        UtilsMisc.onError(context, error.toString());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(),
    );
  }

  Widget _bodyWidget() {
    if (_residents.isEmpty) {
      return UtilsMisc.emptyWidget();
    } else {
      return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _residents.length,
        itemBuilder: (context, idx) => _itemWidget(_residents[idx]),
      );
    }
  }

  Widget _itemWidget(Resident resident) {
    return Card(
      child: UtilsMisc.residentItemWidget(resident),
    );
  }
}
