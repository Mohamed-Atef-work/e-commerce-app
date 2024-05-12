import 'package:e_commerce_app/core/constants/strings.dart';

class AddNewProductsCategoryParams {
  final String name;

  AddNewProductsCategoryParams({
    required this.name,
  });
  Map<String, dynamic> toJson() => {
        kName: name,
      };
}
