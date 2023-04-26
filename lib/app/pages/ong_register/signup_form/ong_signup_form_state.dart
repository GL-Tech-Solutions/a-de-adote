import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

part 'ong_signup_form_state.g.dart';

@match
enum OngSignupFormStatus {
  unknown,
  loading,
  userCreated,
  error,
}

class OngSignupFormState extends Equatable {
  final OngSignupFormStatus status;
  final String? errorMessage;

  const OngSignupFormState({
    required this.status,
    this.errorMessage,
  });

  const OngSignupFormState.initial()
      : status = OngSignupFormStatus.unknown,
        errorMessage = null;

  @override
  List<Object?> get props => [status, errorMessage];

  OngSignupFormState copyWith({
    OngSignupFormStatus? status,
    String? errorMessage,
  }) {
    return OngSignupFormState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
