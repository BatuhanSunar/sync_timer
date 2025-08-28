import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sync_timer/core/container/sync_timer_module.dart';
import 'package:sync_timer/domain/usecases/sync_timer_usecases.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('SERVERTIME DIFF SAVED', () async {
    setUpSyncTimerModule();
    SharedPreferences.setMockInitialValues({});

    final syncTimerUsecases = GetIt.instance<SyncTimerUsecases>();

    final data = await syncTimerUsecases.calculateServerTimeDiff(20250804084703910);
    expect(data, isNotNull);
  });

  test('VERSION', () async {
    setUpSyncTimerModule();
    final syncTimerUsecases = GetIt.instance<SyncTimerUsecases>();

    final version = await syncTimerUsecases.getVersion();

    expect(version, isNotNull);
  });

  test('UNIX TIMESTAMP MILLISECONDS', () async {
    setUpSyncTimerModule();
    final syncTimerUsecases = GetIt.instance<SyncTimerUsecases>();

    final unixTimeMs = await syncTimerUsecases.getUtcNowUnixTimeMilliseconds();

    expect(unixTimeMs, isNotNull);
    expect(unixTimeMs, isA<int>());
    expect(unixTimeMs, greaterThan(0));

    // Unix timestamp milisaniye formatında olmalı (13 hane civarı olacak)
    expect(unixTimeMs.toString().length, greaterThanOrEqualTo(13));
  });
}
