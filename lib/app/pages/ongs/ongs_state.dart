import 'package:equatable/equatable.dart';
import 'package:match/match.dart';
import '../../models/ong_model.dart';
part 'ongs_state.g.dart';

@match
enum OngsStatus {
  initial,
  loading,
  loaded,
  error,
}

class OngsState extends Equatable {
  final OngsStatus status;
  List<OngModel> listOngs;
  final String? errorMessage;

  OngsState({
    required this.status,
    required this.listOngs,
    this.errorMessage,
  });

  OngsState.initial()
      : status = OngsStatus.initial,
        listOngs = [],
        errorMessage = null;

  @override
  List<Object?> get props => [status, listOngs, errorMessage];

  OngsState copyWith({
    OngsStatus? status,
    List<OngModel>? listOngs,
    String? errorMessage,
  }) {
    return OngsState(
      status: status ?? this.status,
      listOngs: listOngs ?? this.listOngs,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
