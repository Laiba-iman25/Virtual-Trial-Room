import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:virtual_trial_room/main.dart'; // Replace with the correct import path for your VirtualTrialRoom widget

void main() {
  testWidgets('VirtualTrialRoom has a camera and capture button', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: VirtualTrialRoom(), // Use VirtualTrialRoom as the root widget
    ));

    // Verify if the app contains the 'Capture' button.
    expect(find.text('Capture'), findsOneWidget);

    // Tap the capture button and trigger a frame.
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump(); // Rebuild the widget after the tap.

    // Verify that a SnackBar with the message 'Picture Taken!' is shown.
    expect(find.text('Picture Taken!'), findsOneWidget);
  });
}
