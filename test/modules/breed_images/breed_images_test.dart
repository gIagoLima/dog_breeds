import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dog_breeds/modules/breed_images/breed_images_page.dart';

void main() {
  testWidgets('BreedImagesPage Test', (WidgetTester tester) async {
    // Build the breed images page widget
    await tester.pumpWidget(MaterialApp(home: BreedImagesPage(breed: 'Test Breed')));

    // Verify if the page title is displayed correctly
    expect(find.text('Test Breed'), findsOneWidget);

    // Simulate actions like tapping on the favorite icon and check if favorite widgets are displayed correctly
    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.favorite_border), findsNothing);
    expect(find.byIcon(Icons.favorite), findsOneWidget);

    // Simulate tapping on the favorite icon again and check if the change is reflected
    await tester.tap(find.byIcon(Icons.favorite));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.favorite), findsNothing);
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);

    // Simulate image loading state and check if images are displayed correctly
    // In this example, assume GetBreedImagesLoaded state is returned
    await tester.pump(Duration.zero); // Wait for UI update
    expect(find.byType(Image), findsWidgets);

    // Simulate GetBreedImagesError state and check if the error message is displayed correctly
    // In this example, assume GetBreedImagesError state is returned
    await tester.pump(Duration.zero); // Wait for UI update
    expect(find.text('Sorry, an error occurred.'), findsOneWidget);

    // Simulate GetBreedImagesLoaded state again and check if images are displayed correctly
    // In this example, assume GetBreedImagesLoaded state is returned
    await tester.pump(Duration.zero); // Wait for UI update
    expect(find.byType(Image), findsWidgets);

    // Simulate loading state and check if the progress indicator is displayed correctly
    // In this example, assume GetBreedImagesLoading state is returned
    await tester.pump(Duration.zero); // Wait for UI update
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}