import 'package:get_it/get_it.dart';
import 'package:sync_timer/data/repositories/sync_timer_repository_impl.dart';
import 'package:sync_timer/domain/repositories/i_sync_timer_repository.dart';
import 'package:sync_timer/domain/usecases/sync_timer_usecases.dart';

final GetIt getIt = GetIt.instance;

void setUpSyncTimerModule() {
  if (getIt.isRegistered<SyncTimerUsecases>()) {
    getIt.unregister<SyncTimerUsecases>();
  }

  if (getIt.isRegistered<ISyncTimerRepository>()) {
    getIt.unregister<ISyncTimerRepository>();
  }

  // Burada ISyncTimerRepository'yi önce register et
  getIt.registerLazySingleton<ISyncTimerRepository>(() => SyncTimerRepositoryImpl());

  // Şimdi güvenle alabilirsin
  final syncTimerRepository = getIt<ISyncTimerRepository>();

  getIt.registerLazySingleton<SyncTimerUsecases>(() => SyncTimerUsecases(syncTimerRepository));
}
