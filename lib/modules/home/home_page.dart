import 'package:dog_breeds/modules/breed_images/breed_images_page.dart';
import 'package:dog_breeds/modules/home/bloc/get_breeds/get_breeds_bloc.dart';
import 'package:dog_breeds/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<GetBreedsBloc>(context).add(GetBreedsListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Breeds"),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(ThemeConstants.defaultPaddingPage),
        child: LayoutBuilder(builder: (context, constraints) {
          return BlocBuilder<GetBreedsBloc, GetBreedsState>(
            builder: (context, state) {
              if (state is GetBreedsError) {
                return const Center(
                  child: Text("Sorry, an error occurred."),
                );
              }
              if (state is GetBreedsLoaded) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      for (int counterBreeds = 0;
                          counterBreeds < state.breeds.length;
                          counterBreeds++)
                        ListTile(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return BreedImagesPage(
                                  breed: state.breeds[counterBreeds].name);
                            }));
                          },
                          leading: const Icon(Icons.pets),
                          title: Text(state.breeds[counterBreeds].name),
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
        }),
      )),
    );
  }
}
