class EnumParser {
  static T fromString<T>(String str, Iterable<T> values) {
    return values.firstWhere(
      (value) => value.toString().split('.')[1] == str,
    );
  }

  static String parseToString(String stringValue) => stringValue.split('.')[1];
}
