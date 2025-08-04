import 'package:sync_timer/domain/repositories/i_sync_timer_repository.dart';

class SyncTimerUsecases {
  final ISyncTimerRepository syncTimerRepository;

  SyncTimerUsecases(this.syncTimerRepository);

  Future<Duration> calculateServerTimeDiff(int serverTime) {
    return syncTimerRepository.calculateServerTimeDiff(serverTime);
  }

  Future<String> getVersion() {
    return syncTimerRepository.getVersion();
  }
}
