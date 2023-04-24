// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';
import 'package:a_de_adote/app/models/pet_model.dart';
part 'pets_state.g.dart';

@match
enum PetsStatus {
  initial,
  loading,
  loaded,
  loadedSearched,
  loadedFiltered,
  error,
}

class PetsState extends Equatable {
  final PetsStatus status;
  List<PetModel> listPets;
  List<PetModel> listPetsSearched;
  List<PetModel> listPetsFiltered;
  Map<String, dynamic>? currentFilters;
  final String? errorMessage;

  PetsState({
    required this.status,
    required this.listPets,
    required this.listPetsSearched,
    required this.listPetsFiltered,
    this.currentFilters,
    this.errorMessage,
  });

  PetsState.initial()
      : status = PetsStatus.initial,
        listPets = [],
        listPetsSearched = [],
        listPetsFiltered = [],
        currentFilters = null,
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

  PetsState copyWith({
    PetsStatus? status,
    List<PetModel>? listPets,
    List<PetModel>? listPetsSearched,
    List<PetModel>? listPetsFiltered,
    Map<String, dynamic>? currentFilters,
    String? errorMessage,
  }) {
    return PetsState(
      status: status ?? this.status,
      listPets: listPets ?? this.listPets,
      listPetsSearched: listPetsSearched ?? this.listPetsSearched,
      listPetsFiltered: listPetsFiltered ?? this.listPetsFiltered,
      currentFilters: currentFilters ?? this.currentFilters,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
