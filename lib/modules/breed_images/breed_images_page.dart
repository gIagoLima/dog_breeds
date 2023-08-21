import 'package:dog_breeds/core/favorites_management.dart';
import 'package:dog_breeds/models/global/breed_image.dart';
import 'package:dog_breeds/models/global/dog_breed.dart';
import 'package:dog_breeds/modules/breed_images/bloc/get_breed_images.dart/get_breed_images_bloc.dart';
import 'package:dog_breeds/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart'
    as cached_manager;

class BreedImagesPage extends StatefulWidget {
  const BreedImagesPage({super.key, required this.breed});
  final String breed;
  @override
  State<BreedImagesPage> createState() => _BreedImagesPageState();
}

class _BreedImagesPageState extends State<BreedImagesPage> {
  bool favoriteBreed = false;
  List<DogBreed> favoritesBreeds = [];
  List<BreedImage> images = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFavoriteBreeds();
    BlocProvider.of<GetBreedImagesBloc>(context)
        .add(GetBreedImagesListEvent(breed: widget.breed));
  }

  Future<void> getFavoriteBreeds() async {
    List<DogBreed>? favoritesBreedsList =
        await FavoritesManagement.getFavoriteBreeds();
    if (favoritesBreedsList != null) {
      favoritesBreeds = favoritesBreedsList;
      checkIfBreedIsFavorite();
    }
  }

  void saveImagesForCache() {
    for (int counterImages = 0;
        counterImages < (images.length >= 5 ? 5 : images.length);
        counterImages++) {
      cached_manager.DefaultCacheManager()
          .downloadFile(images[counterImages].breedImage);
    }
  }

  void checkIfBreedIsFavorite() {
    if (favoritesBreeds
        .where((element) => element.name == widget.breed)
        .isNotEmpty) {
      favoriteBreed = true;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.breed),
        actions: images.isNotEmpty
            ? [
                favoriteBreed
                    ? GestureDetector(
                        onTap: () {
                          FavoritesManagement.removeFavoriteBreeds(
                              DogBreed(name: widget.breed));
                          favoriteBreed = false;
                          setState(() {});
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("removed from favorites")));
                        },
                        child: Icon(Icons.favorite))
                    : GestureDetector(
                        onTap: () {
                          FavoritesManagement.saveFavoriteBreeds(
                              DogBreed(name: widget.breed), [
                            for (int counterImages = 0;
                                counterImages <
                                    (images.length >= 5 ? 5 : images.length);
                                counterImages++)
                              images[counterImages]
                          ]);
                          saveImagesForCache();
                          favoriteBreed = true;
                          setState(() {});
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("added to favorites")));
                        },
                        child: Icon(Icons.favorite_border))
              ]
            : null,
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(ThemeConstants.defaultPaddingPage),
        child: BlocListener<GetBreedImagesBloc, GetBreedImagesState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is GetBreedImagesLoaded) {
              if (images.isEmpty) {
                images = state.images;
                Future.delayed(Duration.zero);
                setState(() {});
              }
            }
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              return BlocBuilder<GetBreedImagesBloc, GetBreedImagesState>(
                builder: (context, state) {
                  if (state is GetBreedImagesError) {
                    return const Center(
                      child: Text("Sorry, an error occurred."),
                    );
                  }
                  if (state is GetBreedImagesLoaded) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          for (int counterImages = 0;
                              counterImages < state.images.length;
                              counterImages++)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Image.network(
                                state.images[counterImages].breedImage,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                      Icons.image_not_supported_outlined);
                                },
                              ),
                            )
                        ],
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );
            },
          ),
        ),
      )),
    );
  }
}
