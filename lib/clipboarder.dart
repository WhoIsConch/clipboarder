import 'package:win32_clipboard/win32_clipboard.dart';

final formatters = <FormatMatcher>[PhoneFormatter(), MacFormatter()];

void clipboardWatcher(String data) {
  final formattedText = formatText(data);

  if (formattedText != null) {
    Clipboard.setText(formattedText);
  }
}

String? formatText(String data) {
  for (var formatter in formatters) {
    String? match = formatter.regex.stringMatch(data.trim());

    // Ensure there is a match and ensure the copy doesn't include more data.
    // If the copied data is more than the matched regex, we want to cancel since
    // we don't want to clear any other important data that might be copied.
    if (match != null && match == data.trim()) {
      print(match);
      return formatter.format(match);
    }
  }

  return null;
}

sealed class FormatMatcher {
  /// The regular expression to match against copied data
  RegExp get regex;

  /// How to format the data if the regex matches
  String format(String data);
}

class PhoneFormatter extends FormatMatcher {
  @override
  RegExp get regex => RegExp(r'^(?!^\d{10}$)\(?\d{3}\)?[ -]?\d{3}[ -]?\d{4}$');

  @override
  String format(String data) => data.replaceAll(RegExp(r'[^0-9]'), '');
}

class MacFormatter extends FormatMatcher {
  @override
  RegExp get regex =>
      RegExp(r'^(([0-9A-Fa-f]{2}:){5}[0-9A-Fa-f]{2}|[0-9A-Fa-f]{12})$');

  @override
  String format(String data) {
    String strippedString = data.replaceAll(':', '');

    return "${strippedString.substring(0, 4)}."
        "${strippedString.substring(4, 8)}."
        "${strippedString.substring(8, 12)}";
  }
}
