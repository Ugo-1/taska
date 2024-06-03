import 'package:flutter_test/flutter_test.dart';
import 'package:taska/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('CreateTaskViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
