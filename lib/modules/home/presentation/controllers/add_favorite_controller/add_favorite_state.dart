import 'package:e_commerce_app/core/utils/enums.dart';

class AddFavoriteState {
  final RequestState addState;
  final String? message;

  const AddFavoriteState({
    this.addState = RequestState.initial,
    this.message,
  });
  AddFavoriteState copyWith({
    RequestState? addState,
    String? message,}
  ) =>
      AddFavoriteState(
        addState: addState ?? this.addState,
        message: message ?? this.message,
      );
}
