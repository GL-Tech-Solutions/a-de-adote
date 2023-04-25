import 'package:equatable/equatable.dart';
import 'package:a_de_adote/app/models/pet_model.dart';
import 'package:match/match.dart';
part 'ong_animals_state.g.dart';

@match
enum OngAnimalStatus {
  initial,
  loading,
  loaded,
  loadedSearched,
  loadedFiltered,
  petDeleted,
  error,
}

// ignore: must_be_immutable
class OngAnimalsState extends Equatable {
  final OngAnimalStatus status;
  List<PetModel> listPets;
  List<PetModel> listPetsSearched;
  List<PetModel> listPetsFiltered;
  Map<String, dynamic>? currentFilters;
  final String? errorMessage;

  OngAnimalsState({
    required this.status,
    required this.listPets,
    required this.listPetsSearched,
    required this.listPetsFiltered,
    this.currentFilters,
    this.errorMessage,
  });

  OngAnimalsState.initial()
      : status = OngAnimalStatus.initial,
        listPets = [],
        listPetsSearched = [],
        listPetsFiltered = [],
        errorMessage = null;

  @override
  List<Object?> get props => [
        status,
        listPets,
        listPetsSearched,
        listPetsFiltered,
        currentFilters,
        errorMessage,
      ];

  OngAnimalsState copyWith({
    OngAnimalStatus? status,
    List<PetModel>? listPets,
    List<PetModel>? listPetsSearched,
    List<PetModel>? listPetsFiltered,
    Map<String, dynamic>? currentFilters,
    String? errorMessage,
  }) {
    return OngAnimalsState(
      status: status ?? this.status,
      listPets: listPets ?? this.listPets,
      listPetsSearched: listPetsSearched ?? this.listPetsSearched,
      listPetsFiltered: listPetsFiltered ?? this.listPetsFiltered,
      currentFilters: currentFilters ?? this.currentFilters,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
