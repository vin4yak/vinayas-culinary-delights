import 'package:html_unescape/html_unescape.dart';

class TextUtil {

  static String unescapedText(String text) {
    return new HtmlUnescape().convert(text);
  }

}
