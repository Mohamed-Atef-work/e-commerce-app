import 'package:equatable/equatable.dart';

class GetFavoritesParams extends Equatable {
  final String uId;

  const GetFavoritesParams({required this.uId});

  @override
  List<Object?> get props => [
        uId,
      ];
}
