import 'package:flutter/material.dart';

buildShowDialog(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(color: Color(0xffFCCFA8)),
        );
      });
}
