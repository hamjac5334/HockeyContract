// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'dart:math';


import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hockey_evaluation_app/main.dart';
import 'package:hockey_evaluation_app/pages/join_organization_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hockey_evaluation_app/pages/new_organization.dart';


void main() async {
  test("Join generates 6 digit code", (){
    var code = NewOrganizationPageState().randomCode.call();
    expect(code.toString().length, 6);
  });
}
