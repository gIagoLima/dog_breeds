import 'package:cached_network_image/cached_network_image.dart';
import 'package:dog_breeds/components/global/rounded_button.dart';
import 'package:dog_breeds/core/favorites_management.dart';
import 'package:dog_breeds/models/global/breed_image.dart';
import 'package:dog_breeds/models/global/dog_breed.dart';
import 'package:dog_breeds/modules/breed_images/breed_images_page.dart';
import 'package:dog_breeds/theme/theme_constants.dart';
import 'package:flutter/material.dart';

class FavoriteBreedsPage extends StatefulWidget {
  const FavoriteBreedsPage({super.key});

  @override
  State<FavoriteBreedsPage> createState() => _FavoriteBreedsPageState();
}

class _FavoriteBreedsPageState extends State<FavoriteBreedsPage> {
  List<DogBreed> favoritesBreeds = [];
  List<BreedImage> images = [];
  String selectedBreedDropDownButton = "";
  bool gettingFavorites = true;

  Future<void> getFavoriteBreeds() async {
    gettingFavorites = true;
    favoritesBreeds = [];
    images = [];

    List<DogBreed>? favoritesBreedsList =
        await FavoritesManagement.getFavoriteBreeds();
    if (favoritesBreedsList != null) {
      favoritesBreeds = favoritesBreedsList;
      selectedBreedDropDownButton = favoritesBreeds.first.name;
      getImagesForBreed();
      return;
    }
    gettingFavorites = false;
    setState(() {});
  }

  Future<void> getImagesForBreed() async {
    List<BreedImage>? imagesList = await FavoritesManagement.getImagesForBreed(
        DogBreed(name: selectedBreedDropDownButton));
    if (imagesList != null) {
      images = imagesList;
      setState(() {});
      gettingFavorites = false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFavoriteBreeds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Breeds"),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(ThemeConstants.defaultPaddingPage),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return !gettingFavorites && favoritesBreeds.isEmpty
                ? const Center(
                    child: Text("No favorite breed selected"),
                  )
                : gettingFavorites
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                      isExpanded: true,
                                      value: selectedBreedDropDownButton,
                                      items: [
                                        for (int counterFavoriteBreeds = 0;
                                            counterFavoriteBreeds <
                                                favoritesBreeds.length;
                                            counterFavoriteBreeds++)
                                          DropdownMenuItem(
                                              value: favoritesBreeds[
                                                      counterFavoriteBreeds]
                                                  .name,
                                              child: Text(favoritesBreeds[
                                                      counterFavoriteBreeds]
                                                  .name))
                                      ],
                                      onChanged: (value) {
                                        selectedBreedDropDownButton = value!;
                                        getImagesForBreed();
                                      }),
                                ),
                              ),
                            ),
                            for (int counterImages = 0;
                                counterImages < images.length;
                                counterImages++)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: CachedNetworkImage(
                                  imageUrl: images[counterImages].breedImage,
                                  errorWidget: (context, error, stackTrace) {
                                    return Icon(
                                        Icons.image_not_supported_outlined);
                                  },
                                ),
                              ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return BreedImagesPage(
                                          breed: selectedBreedDropDownButton);
                                    })).then((value) {
                                      getFavoriteBreeds();
                                      setState(() {});
                                    });
                                  },
                                  child: RoundedButton(
                                    title: "Show more",
                                    constraints: constraints,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      );
          },
        ),
      )),
    );
  }
}
