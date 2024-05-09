part of 'edit_address_cubit.dart';

@immutable
class EditAddressState {
  final RequestState changeState;
  final String message;

  const EditAddressState({
    this.changeState = RequestState.initial,
    this.message = "",
  });

  EditAddressState copyWith({
    RequestState? changeState,
    String? message,
  }) =>
      EditAddressState(
        message: message ?? this.message,
        changeState: changeState ?? this.changeState,
      );
}
