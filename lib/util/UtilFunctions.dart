String getStringFromList(List<String> list) {
  Map<String, String> toExplicitString = {};
  if (list.isEmpty) return "[]";
  list.forEach((element) {
    toExplicitString[element] = "\"" + element + "\"";
  });
  String result = "[";
  toExplicitString.forEach((key, value) {
    result += value + ",";
  });
  result = result.substring(0, result.length - 1);
  if (result.isNotEmpty) result = result + "]";

  return result;
}
