import 'package:dog_breeds/modules/breed_images/breed_images_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dog_breeds/modules/home/home_page.dart';

void main() {
  testWidgets('HomePage Test', (WidgetTester tester) async {
    // Build the home page widget
    await tester.pumpWidget(MaterialApp(home: HomePage()));

    // Verify if the app bar title is displayed correctly
    expect(find.text('Breeds'), findsOneWidget);

    // Simulate the loading state of breeds and check if the progress indicator is displayed
    await tester.pump(Duration.zero); // Wait for UI update
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Simulate the completion of loading breeds and check if the list items are displayed
    await tester.pumpAndSettle(); // Wait for UI update
    expect(find.byType(ListTile), findsWidgets);

    // Simulate tapping a breed in the list and check if navigation is successful
    await tester.tap(find.byType(ListTile).first);
    await tester.pumpAndSettle();
    expect(find.byType(BreedImagesPage), findsOneWidget);
  });
}