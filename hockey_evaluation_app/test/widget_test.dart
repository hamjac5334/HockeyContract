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
import 'package:hockey_evaluation_app/objects/goaltender.dart';
import 'package:hockey_evaluation_app/pages/goaltender_list_view.dart';
import 'package:hockey_evaluation_app/pages/new_goaltender_page.dart';

void main() {
  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);

  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();

  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });

  //Quick plan for tests:

  //When goaltender is added, it joins the list
  testWidgets("When goaltender is added, it joins the list",
      (WidgetTester tester) async {
    List<Goaltender> items = [
      Goaltender(
          name: "Colten Berry",
          levelAge: "15U",
          organization: "Hendrix College")
    ];
    void _handleListChanged(Goaltender goaltender) {
      items.add(goaltender);
    }

    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
      body: GoaltenderListView(
          items: items, onGoaltenderListChanged: _handleListChanged),
    )));
    expect(find.byType(FloatingActionButton), findsOne);
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.byType(NewGoaltenderPage), findsOne);
    await tester.enterText(
        find.byKey(const Key("GoaltenderNameTextField")), "TestName");
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const Key("GoaltenderAgeTextField")), "10");
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const Key("GoaltenderOrganizationTextField")),
        "Hendrix College");
    await tester.pumpAndSettle();

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.byType(NewGoaltenderPage),
        findsNothing); //this is just to test a theory
    /*
      Problem: the floating action button is not popping the new goaltender page for some reason. 
      I am assuming the reason has to do with firebase
      I have a fake firebase installed, but I don't know how to use it...
    */

    expect(find.byType(GoaltenderListView), findsOne);
    expect(find.text("TestName"), findsNothing);
  });

  test("Join generates 6 digit code", (){
    var code = NewOrganizationPageState().randomCode.call();
    expect(code.toString().length, 6);
  });

  //when evaluation is added, it joins the list

  //when goaltender is highlighted, it joins the highlighted list

  //when evaluation is highlighted, it joins the highlighted list

  //when evaluation is closed, it does not display on open evaluations list

  //when evaluation is submitted, it updates the data for the appropriate goaltender?

  //filters goaltender list appropriately

  //sorting orders goaltender list appropriately

  //filters evaluation list appropriately

  //sorting orders evaluation list appropriately

  //ensure drawer navigation works appropriately

  //ensure home screen buttons (if we keep them) work properly

  //
}
