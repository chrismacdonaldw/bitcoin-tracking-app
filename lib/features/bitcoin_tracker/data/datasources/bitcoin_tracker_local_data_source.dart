import 'dart:convert';

import 'package:bitcoin_tracking_app/core/error/exceptions.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/bitcoin_tracker_model.dart';

abstract class BitcoinTrackerLocalDataSource {
  Future<BitcoinTrackerModel> getLastBitcoinInfo();

  Future<void> cacheBitcoinInfo(BitcoinTrackerModel infoToCache);
}

const String CACHED_BITCOIN_INFO = 'CACHED_BITCOIN_INFO';

class BitcoinInfoLocalDataSourceImpl implements BitcoinTrackerLocalDataSource {
  const BitcoinInfoLocalDataSourceImpl({@required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  @override
  Future<BitcoinTrackerModel> getLastBitcoinInfo() {
    final String jsonString = sharedPreferences.getString(CACHED_BITCOIN_INFO);
    if (jsonString != null) {
      return Future<BitcoinTrackerModel>.value(
        BitcoinTrackerModel.fromJson(
          json.decode(jsonString) as Map<String, dynamic>,
        ),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheBitcoinInfo(BitcoinTrackerModel infoToCache) {
    return sharedPreferences.setString(
      CACHED_BITCOIN_INFO,
      json.encode(infoToCache.toJson()),
    );
  }
}
