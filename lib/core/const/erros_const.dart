class ErrosConst {
  static final ErrosConst _singleton = ErrosConst._internal();

  factory ErrosConst() {
    return _singleton;
  }

  ErrosConst._internal();

  static const API_DEFAULT_ERROR =
      "Algo deu errado. Por favor, tente novamente mais tarde";
}
