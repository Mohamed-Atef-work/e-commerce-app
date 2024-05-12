import 'package:equatable/equatable.dart';

class UpDateProductsCategoryParams extends Equatable {
  final String name;
  final String id;

  const UpDateProductsCategoryParams({
    required this.name,
    required this.id,
  });
  Map<String, dynamic> toJson() => {
        "name": name,
      };

  @override
  List<Object?> get props => [
        name,
        id,
      ];
}
