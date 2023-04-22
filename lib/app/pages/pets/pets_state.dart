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
  loadedFiltered,
  error,
}

class PetsState extends Equatable {
  final PetsStatus status;
  List<PetModel> listPets;
  List<PetModel> listPetsFiltered;
  final String? errorMessage;

  PetsState({
    required this.status,
    required this.listPets,
    required this.listPetsFiltered,
    this.errorMessage,
  });

  PetsState.initial()
      : status = PetsStatus.initial,
        listPets = [],
        listPetsFiltered = [],
        errorMessage = null;

  @override
  List<Object?> get props => [status, listPets, listPetsFiltered, errorMessage];

  PetsState copyWith({
    PetsStatus? status,
    List<PetModel>? listPets,
    List<PetModel>? listPetsFiltered,
    String? errorMessage,
  }) {
    return PetsState(
      status: status ?? this.status,
      listPets: listPets ?? this.listPets,
      listPetsFiltered: listPetsFiltered ?? this.listPetsFiltered,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
