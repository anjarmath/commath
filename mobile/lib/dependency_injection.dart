import 'package:commath/features/core/network/connectivity.dart';
import 'package:commath/features/data/repository/auth_repo_impl.dart';
import 'package:commath/features/data/repository/exam_repo_impl.dart';
import 'package:commath/features/data/sources/api_data_source.dart';
import 'package:commath/features/data/sources/api_data_source_impl_http.dart';
import 'package:commath/features/data/sources/middleware.dart';
import 'package:commath/features/data/sources/secure_storage.dart';
import 'package:commath/features/data/sources/secure_storage_impl.dart';
import 'package:commath/features/domain/repository/auth_repo.dart';
import 'package:commath/features/domain/repository/exam_repo.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

/// This function is used to initialize injection of all the dependencies from separate layer
void setupInjection() {
  // Connectivity
  sl.registerLazySingleton<ConnectivityRepository>(
      () => ConnectivityRepositoryImpl());

  sl.registerLazySingleton<ApiDataSource>(() => ApiDataSourceImplHttp(sl()));

  sl.registerLazySingleton<SecureStorage>(() => SecureStorageImpl());

  sl.registerLazySingleton<Middleware>(() => MiddlewareImpl(sl()));

  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(sl(), sl(), sl()));
  sl.registerLazySingleton<ExamRepository>(
      () => ExamRepositoryImpl(sl(), sl(), sl()));
}
