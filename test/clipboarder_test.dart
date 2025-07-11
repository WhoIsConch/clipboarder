import 'package:clipboarder/clipboarder.dart';
import 'package:test/test.dart';
import 'package:win32_clipboard/win32_clipboard.dart';

void main() {
  group('number formatting', () {
    test(
      'number formatter formats numbers separated by spaces',
      () => expect(formatText('123 456 7890'), '1234567890'),
    );

    test(
      'number formatter formats numbers separated by hyphens',
      () => expect(formatText('123-456-7890'), '1234567890'),
    );

    test(
      'number formatter formats numbers from standard format',
      () => expect(formatText('(123) 456-7890'), '1234567890'),
    );

    test(
      'number formatter formats numbers from broken standard format',
      () => expect(formatText('123) 456-7890'), '1234567890'),
    );

    test(
      'number formatter formats numbers that have white space',
      () => expect(formatText(' 123 456 7890 '), '1234567890'),
    );

    test(
      'number formatter doesn\'t format numbers that are already formatted',
      () => expect(formatText('1234567890'), null),
    );

    test(
      'number formatter doesnt\'t format numbers with 9 digits',
      () => expect(formatText('123456789'), null),
    );

    test(
      'number formatter doesn\'t format numbers with 11 digits',
      () => expect(formatText('12345678901'), null),
    );

    test(
      'number formatter doesn\'t format numbers when other data is included',
      () => expect(formatText('test 1234567890'), null),
    );
  });

  group('mac address formatting', () {
    test(
      'mac formatter formats macs that are colon-separated',
      () => expect(formatText('AA:AA:AA:AA:AA:AA'), 'AAAA.AAAA.AAAA'),
    );

    test(
      'mac formatter formats macs that are not separated',
      () => expect(formatText('AAAAAAAAAAAA'), 'AAAA.AAAA.AAAA'),
    );

    test(
      'mac formatter formats macs that have white space',
      () => expect(formatText(' AA:AA:AA:AA:AA:AA '), 'AAAA.AAAA.AAAA'),
    );

    test(
      'mac formatter doesn\'t format non-mac strings that are separated',
      () => expect(formatText('AB:CD:EF:GH:IJ:KL'), null),
    );

    test(
      'mac formatter doesn\'t format non-mac strings that are not separated',
      () => expect(formatText('ABCDEFGHIJKL'), null),
    );

    test(
      'mac formatter doesn\'t format macs that are already formatted',
      () => expect(formatText('AAAA.AAAA.AAAA'), null),
    );

    test(
      'mac formatter doesn\'t format macs when other data is included',
      () => expect(formatText('test AA:AA:AA:AA:AA:AA'), null),
    );
  });

  // Clipboard functionality tests require access to the Windows clipboard.
  group('clipboard functionality', () {
    // Ensure no clipboard data is left that could be the same as the test
    // result
    setUp(() => Clipboard.clear());

    test('program properly copies formatted numbers to clipboard', () {
      clipboardWatcher('123 456 7890');

      expect(Clipboard.getText(), '1234567890');
    });

    test('program properly copies formatted macs to clipboard', () {
      clipboardWatcher('AA:AA:AA:AA:AA:AA');

      expect(Clipboard.getText(), 'AAAA.AAAA.AAAA');
    });
  });
}
