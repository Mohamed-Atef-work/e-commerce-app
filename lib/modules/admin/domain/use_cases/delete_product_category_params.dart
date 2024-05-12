import 'package:equatable/equatable.dart';

class DeleteProductsCategoryParams extends Equatable {
  final String id;
  final String name;

  const DeleteProductsCategoryParams({
    required this.name,
    required this.id,
  });

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}
