import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/shared/domain/entities/shared_user_data_entity.dart';

@immutable
class SharedUserDataState {
  final String? message;
  final RequestState getState;
  final RequestState saveState;
  final SharedUserDataEntity? sharedEntity;
  final RequestState deleteState;

  const SharedUserDataState({
    this.message,
    this.sharedEntity,
    this.getState = RequestState.initial,
    this.saveState = RequestState.initial,
    this.deleteState = RequestState.initial,
  });
  SharedUserDataState copyWith({
    String? message,
    SharedUserDataEntity? sharedEntity,
    RequestState? getState,
    RequestState? saveState,
    RequestState? deleteState,
  }) =>
      SharedUserDataState(
        message: message ?? this.message,
        getState: getState ?? this.getState,
        saveState: saveState ?? this.saveState,
        sharedEntity: sharedEntity ?? this.sharedEntity,
        deleteState: deleteState ?? this.deleteState,
      );
}
