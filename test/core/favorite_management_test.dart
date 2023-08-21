import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:dog_breeds/core/favorites_management.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mockito/mockito.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('FavoritesManagement', () {
    late MockSharedPreferences mockSharedPreferences;

    setUp(() {
      mockSharedPreferences = MockSharedPreferences();
    });

    test('getFavoriteBreeds should return a list of DogBreeds when available', () async {
      when(mockSharedPreferences.getString('favoriteBreeds')).thenReturn(jsonEncode(['breed1', 'breed2']));
      final favoriteBreeds = await FavoritesManagement.getFavoriteBreeds();
      expect(favoriteBreeds, isNotNull);
      expect(favoriteBreeds!.length, 2);
      expect(favoriteBreeds[0].name, 'breed1');
      expect(favoriteBreeds[1].name, 'breed2');
    });

    test('getFavoriteBreeds should return null when favoriteBreeds is not available', () async {
      when(mockSharedPreferences.getString('favoriteBreeds')).thenReturn(null);
      final favoriteBreeds = await FavoritesManagement.getFavoriteBreeds();
      expect(favoriteBreeds, isNull);
    });

  });
}
