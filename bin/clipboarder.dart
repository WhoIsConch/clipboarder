import 'package:clipboarder/clipboarder.dart' as clipboarder;
import 'package:win32_clipboard/win32_clipboard.dart';

void main(List<String> arguments) {
  Clipboard.onTextChanged.listen(clipboarder.clipboardWatcher);
}
