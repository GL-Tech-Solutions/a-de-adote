// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import '../../models/ong_model.dart';

part 'ong_space_state.g.dart';

@match
enum OngSpaceStatus {
  initial,
  loading,
  loaded,
  error,
}

class OngSpaceState extends Equatable {
  final OngSpaceStatus status;
  final OngModel? ong;
  final String? errorMesssage;

  const OngSpaceState({
    required this.status,
    required this.ong,
    this.errorMesssage,
  });

  const OngSpaceState.initial()
      : status = OngSpaceStatus.initial,
        ong = null,
        errorMesssage = null;

  @override
  List<Object?> get props => [status, ong, errorMesssage];

  OngSpaceState copyWith({
    OngSpaceStatus? status,
    OngModel? ong,
    String? errorMesssage,
  }) {
    return OngSpaceState(
      status: status ?? this.status,
      ong: ong ?? this.ong,
      errorMesssage: errorMesssage ?? this.errorMesssage,
    );
  }
}
