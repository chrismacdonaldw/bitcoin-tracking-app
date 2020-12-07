import 'package:bitcoin_tracking_app/features/bitcoin_tracker/domain/entities/bitcoin_tracker.dart';
import 'package:meta/meta.dart';

class BitcoinTrackerModel extends BitcoinTracker {
  const BitcoinTrackerModel({
    @required String symbol,
    @required String name,
    @required double priceUSD,
    @required double percentChange1H,
    @required double percentChange24H,
    @required double percentChange7D,
  }) : super(
          symbol: symbol,
          name: name,
          priceUSD: priceUSD,
          percentChange1H: percentChange1H,
          percentChange24H: percentChange24H,
          percentChange7D: percentChange7D,
        );

  factory BitcoinTrackerModel.fromJson(Map<String, dynamic> json) {
    return BitcoinTrackerModel(
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      priceUSD: double.parse(json['price_usd'] as String),
      percentChange1H: double.parse(json['percent_change_1h'] as String),
      percentChange24H: double.parse(json['percent_change_24h'] as String),
      percentChange7D: double.parse(json['percent_change_7d'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'symbol': symbol,
      'name': name,
      'price_usd': priceUSD.toString(),
      'percent_change_1h': percentChange1H.toString(),
      'percent_change_24h': percentChange24H.toString(),
      'percent_change_7d': percentChange7D.toString(),
    };
  }
}
