// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import 'package:a_de_adote/app/models/pet_model.dart';

part 'pet_details_state.g.dart';

@match
enum PetDetailsStatus {
  initial,
  petLoaded,
  petEdited,
  petDeleted,
  error,
}

class PetDetailsState extends Equatable {
  final PetDetailsStatus status;
  final PetModel? pet;
  final String? errorMessage;

  const PetDetailsState({
    required this.status,
    this.pet,
    this.errorMessage,
  });

  const PetDetailsState.initial()
      : status = PetDetailsStatus.initial,
        pet = null,
        errorMessage = null;

  @override
  List<Object?> get props => [status, pet, errorMessage];

  PetDetailsState copyWith({
    PetDetailsStatus? status,
    PetModel? pet,
    String? errorMessage,
  }) {
    return PetDetailsState(
      status: status ?? this.status,
      pet: pet ?? this.pet,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
