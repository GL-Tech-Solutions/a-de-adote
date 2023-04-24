import 'package:equatable/equatable.dart';
import 'package:match/match.dart';
import '../../models/ong_model.dart';

part 'ongs_state.g.dart';

@match
enum OngsStatus {
  initial,
  loading,
  loaded,
  loadedSearched,
  loadedFiltered,
  error,
}

class OngsState extends Equatable {
  final OngsStatus status;
  List<OngModel> listOngs;
  List<OngModel> listOngsSearched;
  List<OngModel> listOngsFiltered;
  Map<String, dynamic>? currentFilters;
  final String? errorMessage;

  OngsState({
    required this.status,
    required this.listOngs,
    required this.listOngsSearched,
    required this.listOngsFiltered,
    this.currentFilters,
    this.errorMessage,
  });

  OngsState.initial()
      : status = OngsStatus.initial,
        listOngs = [],
        listOngsSearched = [],
        listOngsFiltered = [],
        currentFilters = null,
        errorMessage = null;

  @override
  List<Object?> get props => [
        status,
        listOngs,
        listOngsSearched,
        listOngsFiltered,
        currentFilters,
        errorMessage,
      ];

  OngsState copyWith({
    OngsStatus? status,
    List<OngModel>? listOngs,
    List<OngModel>? listOngsSearched,
    List<OngModel>? listOngsFiltered,
    Map<String, dynamic>? currentFilters,
    String? errorMessage,
  }) {
    return OngsState(
      status: status ?? this.status,
      listOngs: listOngs ?? this.listOngs,
      listOngsSearched: listOngsSearched ?? this.listOngsSearched,
      listOngsFiltered: listOngsFiltered ?? this.listOngsFiltered,
      currentFilters: currentFilters ?? this.currentFilters,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
