// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

part 'reset_password_state.g.dart';

@match
enum ResetPasswordStatus {
  initial,
  loading,
  loaded,
  error,
}

class ResetPasswordState extends Equatable {
  final ResetPasswordStatus status;
  final String? errorMessage;

  const ResetPasswordState({
    required this.status,
    this.errorMessage,
  });

  const ResetPasswordState.initial()
      : status = ResetPasswordStatus.initial,
        errorMessage = null;

  @override
  List<Object?> get props => [status, errorMessage];

  ResetPasswordState copyWith({
    ResetPasswordStatus? status,
    String? errorMessage,
  }) {
    return ResetPasswordState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
