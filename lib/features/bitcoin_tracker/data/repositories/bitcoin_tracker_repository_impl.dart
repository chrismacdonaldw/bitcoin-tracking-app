import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/bitcoin_tracker.dart';
import '../../domain/repositories/bitcoin_tracker_repository.dart';
import '../datasources/bitcoin_tracker_local_data_source.dart';
import '../datasources/bitcoin_tracker_remote_data_source.dart';
import '../models/bitcoin_tracker_model.dart';

class BitcoinTrackerRepositoryImpl implements BitcoinTrackerRepository {
  const BitcoinTrackerRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  final BitcoinTrackerRemoteDataSource remoteDataSource;
  final BitcoinTrackerLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, BitcoinTracker>> getBitcoinInfo() async {
    if (await networkInfo.isConnected) {
      try {
        final BitcoinTrackerModel remoteInfo =
            await remoteDataSource.getBitcoinInfo();
        localDataSource.cacheBitcoinInfo(remoteInfo);
        return Right<Failure, BitcoinTracker>(remoteInfo);
      } on ServerException {
        return Left<Failure, BitcoinTracker>(ServerFailure());
      }
    } else {
      try {
        final BitcoinTrackerModel localInfo =
            await localDataSource.getLastBitcoinInfo();
        return Right<Failure, BitcoinTracker>(localInfo);
      } on CacheException {
        return Left<Failure, BitcoinTracker>(CacheFailure());
      }
    }
  }
}
