import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:flutter/material.dart';

class AddDeleteFavoriteState {
  final int heartIndex;
  final String? message;
  final Color heartColor;
  final RequestState requestState;

  const AddDeleteFavoriteState({
    this.message,
    this.heartIndex = 0,
    this.heartColor = Colors.white,
    this.requestState = RequestState.initial,
  });
  AddDeleteFavoriteState copyWith({
    String? message,
    int? heartIndex,
    Color? heartColor,
    RequestState? requestState,
  }) =>
      AddDeleteFavoriteState(
        message: message ?? this.message,
        heartIndex: heartIndex ?? this.heartIndex,
        heartColor: heartColor ?? this.heartColor,
        requestState: requestState ?? this.requestState,
      );
}
