import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:sync_timer/core/utils/shared_manager_util.dart';
import 'package:sync_timer/domain/repositories/i_sync_timer_repository.dart';

class SyncTimerRepositoryImpl implements ISyncTimerRepository {
  @override
  Future<Duration> calculateServerTimeDiff(int serverTime) async {
    final backendTimestampString = serverTime.toString();

    // if (backendTimestampString.length != 17) {
    //   throw FormatException("Beklenen uzunluk 17 hane ama bu geldi: $backendTimestampString");
    // }

    final year = int.parse(backendTimestampString.substring(0, 4));
    final month = int.parse(backendTimestampString.substring(4, 6));
    final day = int.parse(backendTimestampString.substring(6, 8));
    final hour = int.parse(backendTimestampString.substring(8, 10));
    final minute = int.parse(backendTimestampString.substring(10, 12));
    final second = int.parse(backendTimestampString.substring(12, 14));
    final millisecond = int.parse(backendTimestampString.substring(14, 17));

    final backendDateTime = DateTime(year, month, day, hour, minute, second, millisecond);
    // true = UTC olarak parse et

    final now = DateTime.now().toUtc();

    final diff = now.difference(backendDateTime);

    await SharedManagerUtil.instance.setServerTimeDiff(diff);
    return diff;
  }

  @override
  Future<String> getVersion() async {
    DateTime now = DateTime.now().toUtc();
    final diff = await SharedManagerUtil.instance.getServerTimeDiff();
    final versionDate = diff != null ? now.add(diff) : now;

    // Tarihi formatla (milisaniye hariç)
    final format = DateFormat('yyyyMMddHHmmss');
    final baseFormatted = format.format(versionDate);

    // Milisaniyeyi manuel ekle (3 haneli olacak şekilde)
    final millis = versionDate.millisecond.toString().padLeft(3, '0');

    // Birleştir
    final formatedVersion = '$baseFormatted$millis';
    log("Version: $formatedVersion", name: 'SyncTimer');

    return formatedVersion;
  }

  @override
  Future<int> getUtcNowUnixTimeMilliseconds() async {
    DateTime now = DateTime.now().toUtc();
    // Unix timestamp'i milisaniye cinsinden döndür
    return now.millisecondsSinceEpoch;
  }
}
