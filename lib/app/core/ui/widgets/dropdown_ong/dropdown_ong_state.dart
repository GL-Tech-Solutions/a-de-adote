import 'package:equatable/equatable.dart';
import 'package:match/match.dart';
import '../../../../models/ong_model.dart';

part 'dropdown_ong_state.g.dart';

@match
enum DropdownOngStatus {
  initial,
  loading,
  loaded,
  error,
}

class DropdownOngState extends Equatable {
  final DropdownOngStatus status;
  List<OngModel> listOngs;
  final String? errorMessage;

  DropdownOngState({
    required this.status,
    required this.listOngs,
    this.errorMessage,
  });

  DropdownOngState.initial()
      : status = DropdownOngStatus.initial,
        listOngs = [],
        errorMessage = null;

  @override
  List<Object?> get props => [status, listOngs, errorMessage];

  DropdownOngState copyWith({
    DropdownOngStatus? status,
    List<OngModel>? listOngs,
    String? errorMessage,
  }) {
    return DropdownOngState(
      status: status ?? this.status,
      listOngs: listOngs ?? this.listOngs,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
