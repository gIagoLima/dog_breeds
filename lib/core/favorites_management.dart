import 'dart:convert';

import 'package:dog_breeds/models/global/breed_image.dart';
import 'package:dog_breeds/models/global/dog_breed.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesManagement {
  static Future<List<DogBreed>?> getFavoriteBreeds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? favoriteBreeds = prefs.getString('favoriteBreeds');
    if (favoriteBreeds != null) {
      return (jsonDecode(favoriteBreeds) as List)
          .map((e) => DogBreed(name: e))
          .toList();
    }
    return null;
  }

  static Future<List<BreedImage>?> getImagesForBreed(DogBreed breed) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? breedImages = prefs.getString(breed.name);
    if (breedImages != null) {
      return (jsonDecode(breedImages) as List)
          .map((e) => BreedImage(breedImage: e))
          .toList();
    }
    return null;
  }

  static Future<bool> saveFavoriteBreeds(
      DogBreed breed, List<BreedImage> images) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? favoriteBreeds = prefs.getString('favoriteBreeds');
      List breeds = [];
      if (favoriteBreeds != null) {
        breeds = jsonDecode(favoriteBreeds);
      }
      breeds.add(breed.name);
      prefs.setString("favoriteBreeds", jsonEncode(breeds));
      prefs.setString(
          breed.name, jsonEncode(images.map((e) => e.breedImage).toList()));

      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> removeFavoriteBreeds(DogBreed breed) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? favoriteBreeds = prefs.getString('favoriteBreeds');
      List breeds = [];
      if (favoriteBreeds != null) {
        breeds = jsonDecode(favoriteBreeds);
      }
      breeds.removeWhere((element) => element == breed.name);
      if (breeds.isNotEmpty) {
        prefs.setString("favoriteBreeds", jsonEncode(breeds));
      } else {
        prefs.remove("favoriteBreeds");
      }

      prefs.remove(breed.name);
      return true;
    } catch (e) {
      return false;
    }
  }
}
