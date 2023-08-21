part of 'get_breed_images_bloc.dart';

abstract class GetBreedImagesEvent extends Equatable {
  const GetBreedImagesEvent();

  @override
  List<Object> get props => [];
}

class GetBreedImagesListEvent extends GetBreedImagesEvent {
  final String breed;
  const GetBreedImagesListEvent({required this.breed});
  @override
  List<Object> get props => [];
}
