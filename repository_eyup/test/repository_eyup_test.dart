import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repository_eyup/repository_eyup.dart';

void main() {
  const MethodChannel channel = MethodChannel('repository_eyup');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await RepositoryEyup.platformVersion, '42');
  });
}
