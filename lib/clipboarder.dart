import 'package:win32_clipboard/win32_clipboard.dart';

// Matches a phone number formatted with parenthesis and dashes
const phoneRegexStr = r'^(?!^\d{10}$)\(?\d{3}\)?[ -]?\d{3}[ -]?\d{4}$';

void clipboardWatcher(String data) {
  final phoneRegex = RegExp(phoneRegexStr);

  String? match = phoneRegex.stringMatch(data.trim());

  if (match != data.trim()) {
    // This means the data includes more than just the number. In that case,
    // we don't format anything.
    return;
  } else if (match != null) {
    // Strip the matched string of anything that isn't a number
    String formattedString = match.replaceAll(RegExp(r'[^0-9]'), '');

    Clipboard.setText(formattedString);
    // print('Pasted $formattedString to clipboard');
  }
}
