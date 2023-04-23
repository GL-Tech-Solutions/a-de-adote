// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:a_de_adote/app/models/pet_model.dart';
import 'package:match/match.dart';

part 'ong_animals_state.g.dart';

@match
enum OngAnimalStatus {
  initial,
  loading,
  loaded,
  loadedFiltered,
  petDeleted,
  error,
}

class OngAnimalsState extends Equatable {
  final OngAnimalStatus status;
  List<PetModel> listPets;
  List<PetModel> listPetsFiltered;
  final String? errorMessage;

  OngAnimalsState({
    required this.status,
    required this.listPets,
    required this.listPetsFiltered,
    this.errorMessage,
  });

  OngAnimalsState.initial()
      : status = OngAnimalStatus.initial,
        listPets = [],
        listPetsFiltered = [],
        errorMessage = null;

  @override
  List<Object?> get props => [status, listPets, listPetsFiltered, errorMessage];

  OngAnimalsState copyWith({
    OngAnimalStatus? status,
    List<PetModel>? listPets,
    List<PetModel>? listPetsFiltered,
    String? errorMessage,
  }) {
    return OngAnimalsState(
      status: status ?? this.status,
      listPets: listPets ?? this.listPets,
      listPetsFiltered: listPetsFiltered ?? this.listPetsFiltered,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
