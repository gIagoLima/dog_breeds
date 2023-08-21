import 'package:cached_network_image/cached_network_image.dart';
import 'package:dog_breeds/modules/breed_images/breed_images_page.dart';
import 'package:dog_breeds/modules/favorites/favorites_breeds_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('FavoriteBreedsPage Test', (WidgetTester tester) async {
    // Build the favorite breeds page widget
    await tester.pumpWidget(MaterialApp(home: FavoriteBreedsPage()));

    // Verify if the app bar title is displayed correctly
    expect(find.text('Favorite Breeds'), findsOneWidget);

    // Simulate the loading state of favorite breeds and check if the progress indicator is displayed
    await tester.pump(Duration.zero); // Wait for UI update
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Simulate the completion of loading favorite breeds and check if the dropdown button is displayed
    await tester.pumpAndSettle(); // Wait for UI update
    expect(find.byType(DropdownButton<String>), findsOneWidget);

    // Select a breed from the dropdown and verify if the breed is set and images are loaded
    await tester.tap(find.byType(DropdownButton<String>));
    await tester.pumpAndSettle();
    await tester.tap(
        find.text('Test Breed')); // Assuming 'Test Breed' is one of the options
    await tester.pumpAndSettle();
    expect(find.text('Test Breed'), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsWidgets);

    // Simulate tapping the 'Show more' button and check if navigation and state changes are reflected
    await tester.tap(find.text('Show more'));
    await tester.pumpAndSettle();
    expect(find.byType(BreedImagesPage), findsOneWidget);
  });
}
