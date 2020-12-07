import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/bitcoin_tracker.dart';

abstract class BitcoinTrackerRepository {
  Future<Either<Failure, BitcoinTracker>> getBitcoinInfo();
}
