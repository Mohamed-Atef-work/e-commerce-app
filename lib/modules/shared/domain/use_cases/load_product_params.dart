import 'package:equatable/equatable.dart';

class LoadProductsParams extends Equatable {
  final String category;

  const LoadProductsParams({required this.category});

  @override
  List<Object?> get props => [category];
}
