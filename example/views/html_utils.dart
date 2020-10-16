class HtmlUtils {
  static String attrs(Map<String, String> attrs) {
    final sb = StringBuffer();
    for (final key in attrs.keys) {
      sb.write(key);
      sb.write('="');
      sb.write(attrs[key]);
      sb.write('"');
    }

    return sb.toString();
  }
}
