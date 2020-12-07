import 'dart:async';

import 'package:bitcoin_tracking_app/core/error/failures.dart';
import 'package:bitcoin_tracking_app/core/usecases/usecase.dart';
import 'package:bitcoin_tracking_app/features/bitcoin_tracker/domain/entities/bitcoin_tracker.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../domain/usecases/get_bitcoin_info.dart';
import './bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class BitcoinTrackerBloc
    extends Bloc<BitcoinTrackerEvent, BitcoinTrackerState> {
  BitcoinTrackerBloc({@required GetBitcoinInfo info})
      : assert(info != null),
        getBitcoinInfo = info,
        super(Empty());

  final GetBitcoinInfo getBitcoinInfo;

  @override
  Stream<BitcoinTrackerState> mapEventToState(
      BitcoinTrackerEvent event) async* {
    if (event is GetInfoForBitcoin) {
      yield Loading();
      final Either<Failure, BitcoinTracker> failureOrInfo =
          await getBitcoinInfo(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrInfo);
    }
  }

  Stream<BitcoinTrackerState> _eitherLoadedOrErrorState(
      Either<Failure, BitcoinTracker> failureOrInfo) async* {
    yield failureOrInfo.fold(
      (Failure failure) => Error(message: _mapFailureToMessage(failure)),
      (BitcoinTracker info) => Loaded(bitcoinTracker: info),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
