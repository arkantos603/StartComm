class Validator {
  Validator._();

  static String? validateName(String? value) {
    final condition = RegExp(r"((\ *)[\wáéíóúñ]+(\ *)+)+");
    if (value != null && value.isEmpty) {
      return "Esse campo não pode ser vazio.";
    }
    if (value != null && !condition.hasMatch(value)) {
      return "Nome inválido. Digite um nome válido.";
    }
    return null;
  }

  static String? validateEmpresa(String? value) {
    final condition = RegExp(r"((\ *)[\wáéíóúñ]+(\ *)+)+");
    if (value != null && value.isEmpty) {
      return "Esse campo não pode ser vazio.";
    }
    if (value != null && !condition.hasMatch(value)) {
      return "Nome inválido. Digite um nome válido para empresa.";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    final condition = RegExp(
        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
    if (value != null && value.isEmpty) {
      return "Esse campo não pode ser vazio.";
    }
    if (value != null && !condition.hasMatch(value)) {
      return "Email inválido. Digite um email válido.";
    }
    return null;
  }

  static String? validatePassword(String? value) {
  final condition = RegExp(r"^.{8,}$");
  if (value != null && value.isEmpty) {
    return "Esse campo não pode ser vazio.";
  }
  if (value != null && !condition.hasMatch(value)) {
    return "Senha inválida. A senha deve ter no mínimo 8 caracteres.";
  }
  return null;
}

  static String? validateConfirmPassword(
    String? passwordValue,
    String? confirmPasswordValue,
  ) {
    if (passwordValue != confirmPasswordValue) {
      return "As senhas são diferentes. Por favor, corrija para continuar.";
    }
    return null;
  }
}