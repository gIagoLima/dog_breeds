import 'package:bloc/bloc.dart';
import 'package:dog_breeds/models/global/breed_image.dart';
import 'package:dog_breeds/repositories/breed_images/list_breed_images_repository_controller.dart';
import 'package:equatable/equatable.dart';

part 'get_breed_images_event.dart';
part 'get_breed_images_state.dart';

class GetBreedImagesBloc
    extends Bloc<GetBreedImagesEvent, GetBreedImagesState> {
  GetBreedImagesBloc() : super(GetBreedImagesInitial()) {
    on<GetBreedImagesEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is GetBreedImagesListEvent) {
        emit(GetBreedImagesLoading());
        List<BreedImage>? images =
            await _listBreedsImagesRepositoryController.list(event.breed);
        if (images != null) {
          emit(GetBreedImagesLoaded(images: images));
        } else {
          emit(GetBreedImagesError());
        }
      }
    });
  }
  final ListBreedsImagesRepositoryController
      _listBreedsImagesRepositoryController =
      ListBreedsImagesRepositoryController();
}
