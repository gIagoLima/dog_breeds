import 'dart:convert';

import 'package:dog_breeds/core/endpoints.dart';
import 'package:dog_breeds/models/global/breed_image.dart';
import 'package:http/http.dart' as http;

class ListBreedsImagesRepositoryController {
  Future<List<BreedImage>?> list(String breed) async {
    Uri uri = Uri.http(
      Endpoints.urlDomain,
      Endpoints.listAllBreedsImagesPath.replaceAll("#BREED#", breed),
    );
    try {
      http.Response response = await http.get(
        uri,
      );

      if (response.statusCode == 200) {
        Map responseObject = jsonDecode(response.body);
        return (responseObject["message"] as List)
            .map((e) => BreedImage(breedImage: e))
            .toList();
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
