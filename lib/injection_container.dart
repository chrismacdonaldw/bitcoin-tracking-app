import 'package:bitcoin_tracking_app/features/bitcoin_tracker/presentation/bloc/bitcoin_tracker_bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/bitcoin_tracker/data/datasources/bitcoin_tracker_local_data_source.dart';
import 'features/bitcoin_tracker/data/datasources/bitcoin_tracker_remote_data_source.dart';
import 'features/bitcoin_tracker/data/repositories/bitcoin_tracker_repository_impl.dart';
import 'features/bitcoin_tracker/domain/repositories/bitcoin_tracker_repository.dart';
import 'features/bitcoin_tracker/domain/usecases/get_bitcoin_info.dart';
import 'features/bitcoin_tracker/presentation/bloc/bitcoin_tracker_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    () => BitcoinTrackerBloc(info: sl()),
  );

  sl.registerLazySingleton(() => GetBitcoinInfo(sl()));

  sl.registerLazySingleton<BitcoinTrackerRepository>(
    () => BitcoinTrackerRepositoryImpl(
      localDataSource: sl(),
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<BitcoinTrackerRemoteDataSource>(
    () => BitcoinTrackerRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<BitcoinTrackerLocalDataSource>(
    () => BitcoinInfoLocalDataSourceImpl(sharedPreferences: sl()),
  );

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
