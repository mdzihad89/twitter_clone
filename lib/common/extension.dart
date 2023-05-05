import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension ExtendedNavigator on BuildContext {
  Future<dynamic> pushReplacement(Widget page) async {
    Navigator.pushReplacement(this, MaterialPageRoute(builder: (_) => page));
  }

  Future<dynamic> push(Widget page) async {
    Navigator.push(this, MaterialPageRoute(builder: (_) => page));
  }

  Future<dynamic> pushAndRemoveUntil(Widget page) async {
    Navigator.pushAndRemoveUntil(
      this,
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    );
  }
}

extension Logger on Object {
  void log() {
    debugPrint(toString());
  }
}
