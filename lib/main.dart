import 'package:dog_breeds/modules/breed_images/bloc/get_breed_images.dart/get_breed_images_bloc.dart';
import 'package:dog_breeds/modules/home/bloc/get_breeds/get_breeds_bloc.dart';
import 'package:dog_breeds/modules/nav_bar/bottom_nav_bar_screen.dart';
import 'package:dog_breeds/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<GetBreedsBloc>(
        create: (context) => GetBreedsBloc(),
      ),
      BlocProvider<GetBreedImagesBloc>(
        create: (context) => GetBreedImagesBloc(),
      ),
    ],
    child: MaterialApp(
      theme: ThemeData(
          appBarTheme: AppBarTheme(backgroundColor: ThemeConstants.mainColor)),
      home:const BottomNavBarScreen(),
    ),
  ));
}
