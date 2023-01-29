import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_meals/user_meals/delete_resident.dart';
import 'package:user_meals/user_meals/entities/resident.dart';
import 'package:user_meals/user_meals/get_resident.dart';
import 'package:user_meals/user_meals/repositories/resident_repository.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getResidents();
    });
  }

  void _getResidents() {
    Provider.of<GetResident>(context, listen: false)
        .execute()
        .then((value) => setState(() => _residents.addAll(value)))
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
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Row(children: [
          UtilsMisc.residentItemWidget(resident),
          GestureDetector(
            onTap: () {
              Provider.of<DeleteResident>(context, listen: false)
                  .execute(resident.id())
                  .then((value) {
                setState(() => _residents.remove(resident));
              }).onError((error, stackTrace) {
                UtilsMisc.onError(context, error.toString());
              });
            },
            child: const Icon(Icons.delete),
          )
        ]),
      ),
    );
  }
}
