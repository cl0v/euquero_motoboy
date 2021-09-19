class EmailFieldValidator {
  static String? validate(String? value) {
    if (value != null) {
      return value.isEmpty ? 'Email can\'t be empty' : null;
    }
  }
}

class PasswordFieldValidator {
  static String? validate(String? value) {
    if (value != null) {
    return value.isEmpty ? 'Senha não pode ser vazia' : null;
    }
  }
}
