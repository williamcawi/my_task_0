import 'package:flutter/widgets.dart';

mixin Validators {
  final GlobalKey<FormState> keyForm = GlobalKey();

  String? titleValidator(String? title) {
    if (title == '' || title == null) {
      return 'o campo de titulo é obrigatório';
    }

    return null;
  }

  String? descriptionValidator(String? description) {
    if (description == '' || description == null) {
      return 'o campo de descrição é obrigatório';
    }

    return null;
  }
}
