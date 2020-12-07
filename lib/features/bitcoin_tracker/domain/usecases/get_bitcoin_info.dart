import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/bitcoin_tracker.dart';
import '../repositories/bitcoin_tracker_repository.dart';

class GetBitcoinInfo implements UseCase<BitcoinTracker, NoParams> {
  const GetBitcoinInfo(this.repository);

  final BitcoinTrackerRepository repository;

  @override
  Future<Either<Failure, BitcoinTracker>> call(NoParams params) async {
    return await repository.getBitcoinInfo();
  }
}
