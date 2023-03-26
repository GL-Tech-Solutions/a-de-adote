// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

part 'pet_register_state.g.dart';

@match
enum PetRegisterStatus {
  unknown,
  loading,
  petCreated,
  imageLoaded,
  error,
}

class PetRegisterState extends Equatable {
  final PetRegisterStatus status;
  File? image;
  final String? errorMessage;

  PetRegisterState({
    required this.status,
    this.image,
    this.errorMessage,
  });

  PetRegisterState.initial()
      : status = PetRegisterStatus.unknown,
        image = null,
        errorMessage = null;

  @override
  List<Object?> get props => [status, image, errorMessage];

  PetRegisterState copyWith({
    PetRegisterStatus? status,
    File? image,
    String? errorMessage,
  }) {
    return PetRegisterState(
      status: status ?? this.status,
      image: image ?? this.image,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
