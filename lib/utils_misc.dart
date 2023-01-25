import 'package:flutter/material.dart';

class UtilsMisc {
  static onError(BuildContext context, String error) {
    final snackBar = SnackBar(
      content: Text(error),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
