import 'dart:convert';

import 'package:dog_breeds/core/endpoints.dart';
import 'package:dog_breeds/models/global/dog_breed.dart';
import 'package:http/http.dart' as http;

class ListBreedsRepositoryController {
  Future<List<DogBreed>?> list() async {
    Uri uri = Uri.http(
      Endpoints.urlDomain,
      Endpoints.listAllBreedsPath,
    );
    try {
      
    
    http.Response response = await http.get(
      uri,
    );

    if (response.statusCode == 200) {
      Map responseObject = jsonDecode(response.body);
      return (responseObject["message"] as Map)
          .keys
          .map((e) => DogBreed(name: e))
          .toList();
    }
    return null;
    } catch (e) {
     return null; 
    }
  }
}
