part of 'get_breeds_bloc.dart';

sealed class GetBreedsState extends Equatable {
  const GetBreedsState();

  @override
  List<Object> get props => [];
}

final class GetBreedsInitial extends GetBreedsState {}

final class GetBreedsLoading extends GetBreedsState {}

final class GetBreedsLoaded extends GetBreedsState {
  final List<DogBreed> breeds;
  const GetBreedsLoaded({required this.breeds});
}

final class GetBreedsError extends GetBreedsState {}
