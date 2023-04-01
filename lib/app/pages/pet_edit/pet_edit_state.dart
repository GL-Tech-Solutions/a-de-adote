// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

part 'pet_edit_state.g.dart';

@match
enum PetEditStatus {
  initial,
  petLoaded,
  loading,
  petUpdated,
  imageUpdated,
  error,
}

class PetEditState extends Equatable {
  final PetEditStatus status;
  File? image;
  final String? errorMessage;

  PetEditState({
    required this.status,
    this.image,
    this.errorMessage,
  });

  PetEditState.initial()
      : status = PetEditStatus.initial,
        image = null,
        errorMessage = null;

  @override
  List<Object?> get props => [status, image, errorMessage];

  PetEditState copyWith({
    PetEditStatus? status,
    File? image,
    String? errorMessage,
  }) {
    return PetEditState(
      status: status ?? this.status,
      image: image ?? this.image,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
