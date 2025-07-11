import 'dart:io';

import 'package:clipboarder/clipboarder.dart' as clipboarder;
import 'package:win32_clipboard/win32_clipboard.dart';
import 'package:win32/win32.dart';

void main(List<String> arguments) {
  if (Platform.isWindows) {
    ShowWindow(GetConsoleWindow(), SW_HIDE);
  }
  Clipboard.onTextChanged.listen(clipboarder.clipboardWatcher);
}
