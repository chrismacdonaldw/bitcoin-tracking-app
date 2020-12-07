import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BitcoinTrackerEvent extends Equatable {
  @override
  List<Object> get props => <Object>[];
}

class GetInfoForBitcoin extends BitcoinTrackerEvent {}
