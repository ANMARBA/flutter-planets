import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_planets/core/data/repositories/network_repository_impl.dart';
import 'package:flutter_planets/core/domain/repositories/network_repository.dart';
import 'package:flutter_planets/core/presentation/routes/app_router.dart';
import 'package:flutter_planets/core/shared/server/server_api_client.dart';
import 'package:flutter_planets/features/planets/data/datasources/remote/planets_remote_datasource.dart';
import 'package:flutter_planets/features/planets/data/datasources/remote/planets_remote_datasource_impl.dart';
import 'package:flutter_planets/features/planets/data/repositories/planets_repository_impl.dart';
import 'package:flutter_planets/features/planets/domain/repositories/planets_repository.dart';

final locator = GetIt.I;
Future<void> setupLocator() async {
  //! Core
  locator.registerSingleton<AppRouter>(AppRouter());
  locator.registerLazySingleton<NetworkInfoRepository>(
    () => NetworkInfoRepositoryImpl(),
  );
  locator.registerLazySingleton(() => ServerApiClient());

  //! External
  locator.registerSingletonAsync<SharedPreferences>(
    () => SharedPreferences.getInstance(),
  );
  await locator.isReady<SharedPreferences>();

  //! Data Sources
  locator.registerLazySingleton<PlanetsRemoteDataSource>(
    () => PlanetsRemoteDataSourceImpl(
      apiClient: locator<ServerApiClient>(),
    ),
  );

  //! Repositories
  locator.registerLazySingleton<PlanetsRepository>(() => PlanetsRepositoryImpl(
        remoteDataSource: locator<PlanetsRemoteDataSource>(),
      ));
}
