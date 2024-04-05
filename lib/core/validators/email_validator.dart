class EmailValidator {
  static final EmailValidator _singleton = EmailValidator._internal();

  factory EmailValidator() {
    return _singleton;
  }

  EmailValidator._internal();

  static String? validate(String? email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$');
    if (email == null || email.isEmpty) {
      return 'A email é obrigatoria';
    } else if (!emailRegex.hasMatch(email)) {
      return 'Esse email não é valido';
    } else if (email.length > 200) {
      return 'Seu email deve conter no maximo 200 caracteres';
    }
    return null;
  }
}
