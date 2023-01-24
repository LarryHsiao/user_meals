import 'package:flutter/material.dart';
import 'package:user_meals/user_meals/entities/resident.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(),
    );
  }

  Widget _bodyWidget() {
    if (_residents.isEmpty) {
      return _emptyWidget();
    } else {
      return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _residents.length,
        itemBuilder: (context, idx) {
          return Container(
            child: Center(
              child: Text("Text"),
            ),
          );
        },
      );
    }
  }

  Widget _emptyWidget() {
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
}
