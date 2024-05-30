import 'package:e_commerce_app/core/constants/strings.dart';
import 'package:equatable/equatable.dart';

class UpDateProductsCategoryParams extends Equatable {
  final String oldName;
  final String newName;
  final String id;

  const UpDateProductsCategoryParams({
    required this.oldName,
    required this.newName,
    required this.id,
  });
  Map<String, dynamic> toJson() => {
        kName: newName,
      };

  @override
  List<Object?> get props => [
        oldName,
        newName,
        id,
      ];
}
