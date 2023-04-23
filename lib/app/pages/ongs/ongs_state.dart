import 'package:equatable/equatable.dart';
import 'package:match/match.dart';
import '../../models/ong_model.dart';

part 'ongs_state.g.dart';

@match
enum OngsStatus {
  initial,
  loading,
  loaded,
  loadedFiltered,
  error,
}

class OngsState extends Equatable {
  final OngsStatus status;
  List<OngModel> listOngs;
  List<OngModel> listOngsFiltered;
  final String? errorMessage;

  OngsState({
    required this.status,
    required this.listOngs,
    required this.listOngsFiltered,
    this.errorMessage,
  });

  OngsState.initial()
      : status = OngsStatus.initial,
        listOngs = [],
        listOngsFiltered = [],
        errorMessage = null;

  @override
  List<Object?> get props => [status, listOngs, listOngsFiltered, errorMessage];

  OngsState copyWith({
    OngsStatus? status,
    List<OngModel>? listOngs,
    List<OngModel>? listOngsFiltered,
    String? errorMessage,
  }) {
    return OngsState(
      status: status ?? this.status,
      listOngs: listOngs ?? this.listOngs,
      listOngsFiltered: listOngsFiltered ?? this.listOngsFiltered,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
