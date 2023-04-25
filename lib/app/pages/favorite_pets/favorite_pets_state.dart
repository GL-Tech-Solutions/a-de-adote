import 'package:equatable/equatable.dart';
import 'package:match/match.dart';
import '../../models/pet_model.dart';

part 'favorite_pets_state.g.dart';

@match
enum FavoritePetsStatus {
  initial,
  loading,
  loaded,
  error,
}

class FavoritePetsState extends Equatable {
  final FavoritePetsStatus status;
  final List<PetModel> listFavoritePets;
  final String? errorMessage;

  const FavoritePetsState({
    required this.status,
    required this.listFavoritePets,
    this.errorMessage,
  });

  FavoritePetsState.initial()
      : status = FavoritePetsStatus.initial,
        listFavoritePets = [],
        errorMessage = null;

  @override
  List<Object?> get props => [status, listFavoritePets, errorMessage];

  FavoritePetsState copyWith({
    FavoritePetsStatus? status,
    List<PetModel>? listFavoritePets,
    String? errorMessage,
  }) {
    return FavoritePetsState(
      status: status ?? this.status,
      listFavoritePets: listFavoritePets ?? this.listFavoritePets,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
