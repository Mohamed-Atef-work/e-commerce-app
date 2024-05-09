import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/user/domain/entities/favorite_entity.dart';
import 'package:flutter/material.dart';

class ManageFavoriteState {
  final int heartIndex;
  final String? message;
  final Color heartColor;
  final List<FavoriteEntity> favorites;
  final RequestState requestState;

  const ManageFavoriteState({
    this.message,
    this.heartIndex = 0,
    this.heartColor = Colors.white,
    this.favorites = const [],
    this.requestState = RequestState.initial,
  });
  ManageFavoriteState copyWith({
    String? message,
    int? heartIndex,
    Color? heartColor,
    List<FavoriteEntity>? favorites,
    RequestState? requestState,
  }) =>
      ManageFavoriteState(
        message: message ?? this.message,
        favorites: favorites ?? this.favorites,
        heartIndex: heartIndex ?? this.heartIndex,
        heartColor: heartColor ?? this.heartColor,
        requestState: requestState ?? this.requestState,
      );
}
