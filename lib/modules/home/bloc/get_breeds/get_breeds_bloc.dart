import 'package:bloc/bloc.dart';
import 'package:dog_breeds/models/global/dog_breed.dart';
import 'package:dog_breeds/repositories/home/list_breeds_repository_controller.dart';
import 'package:equatable/equatable.dart';

part 'get_breeds_event.dart';
part 'get_breeds_state.dart';

class GetBreedsBloc extends Bloc<GetBreedsEvent, GetBreedsState> {
  GetBreedsBloc() : super(GetBreedsInitial()) {
    on<GetBreedsEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is GetBreedsListEvent) {
        emit(GetBreedsLoading());
        List<DogBreed>? breeds = await _listBreedsRepositoryController.list();
        if (breeds != null) {
          emit(GetBreedsLoaded(breeds: breeds));
        } else {
          emit(GetBreedsError());
        }
      }
    });
  }
  final ListBreedsRepositoryController _listBreedsRepositoryController =
      ListBreedsRepositoryController();
}
