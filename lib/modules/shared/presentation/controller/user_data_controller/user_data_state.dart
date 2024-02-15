import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/shared/domain/entities/shared_user_data_entity.dart';

@immutable
class SharedUserDataState {
  final String? message;
  final RequestState getState;
  final RequestState saveState;
  final RequestState deleteState;
  final RequestState afterLoginState;
  final SharedUserDataEntity? sharedEntity;

  const SharedUserDataState({
    this.message,
    this.sharedEntity,
    this.getState = RequestState.initial,
    this.saveState = RequestState.initial,
    this.deleteState = RequestState.initial,
    this.afterLoginState = RequestState.initial,
  });
  SharedUserDataState copyWith({
    String? message,
    RequestState? getState,
    RequestState? saveState,
    RequestState? deleteState,
    RequestState? afterLoginState,
    SharedUserDataEntity? sharedEntity,
  }) =>
      SharedUserDataState(
        message: message ?? this.message,
        getState: getState ?? this.getState,
        saveState: saveState ?? this.saveState,
        deleteState: deleteState ?? this.deleteState,
        sharedEntity: sharedEntity ?? this.sharedEntity,
        afterLoginState: deleteState ?? this.afterLoginState,
      );
}
