import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class BitcoinTracker extends Equatable {
  const BitcoinTracker({
    @required this.symbol,
    @required this.name,
    @required this.priceUSD,
    @required this.percentChange1H,
    @required this.percentChange24H,
    @required this.percentChange7D,
  });

  final String symbol;
  final String name;
  final double priceUSD;
  final double percentChange1H;
  final double percentChange24H;
  final double percentChange7D;

  @override
  List<Object> get props => <Object>[
        symbol,
        name,
        priceUSD,
        percentChange1H,
        percentChange24H,
        percentChange7D
      ];
}
