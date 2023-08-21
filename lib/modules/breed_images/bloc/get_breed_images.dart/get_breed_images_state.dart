part of 'get_breed_images_bloc.dart';

sealed class GetBreedImagesState extends Equatable {
  const GetBreedImagesState();

  @override
  List<Object> get props => [];
}

final class GetBreedImagesInitial extends GetBreedImagesState {}

final class GetBreedImagesLoading extends GetBreedImagesState {}

final class GetBreedImagesLoaded extends GetBreedImagesState {
  final List<BreedImage> images;
  const GetBreedImagesLoaded({required this.images});
}

final class GetBreedImagesError extends GetBreedImagesState {}
