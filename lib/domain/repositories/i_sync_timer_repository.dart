abstract class ISyncTimerRepository {
  Future<Duration> calculateServerTimeDiff(int serverTime);

  Future<String> getVersion();
}
