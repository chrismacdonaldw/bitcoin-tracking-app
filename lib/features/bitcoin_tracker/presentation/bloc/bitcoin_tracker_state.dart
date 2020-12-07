import 'package:bitcoin_tracking_app/features/bitcoin_tracker/domain/entities/bitcoin_tracker.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BitcoinTrackerState extends Equatable {
  @override
  List<Object> get props => <Object>[];
}

class Empty extends BitcoinTrackerState {}

class Loading extends BitcoinTrackerState {}

class Loaded extends BitcoinTrackerState {
  Loaded({@required this.bitcoinTracker});

  final BitcoinTracker bitcoinTracker;

  @override
  List<Object> get props => <Object>[bitcoinTracker];
}

class Error extends BitcoinTrackerState {
  Error({@required this.message});

  final String message;

  @override
  List<Object> get props => <Object>[message];
}
