String getStringFromList(List<String> list) {
  Map<String, String> toExplicitString = {};
  list.forEach((element) {
    toExplicitString[element] = "\"" + element + "\"";
  });
  String result = "[";
  toExplicitString.forEach((key, value) {
    result += value + ",";
  });
  result = result.substring(0, result.length - 1);
  result = result + "]";
  return result;
}
