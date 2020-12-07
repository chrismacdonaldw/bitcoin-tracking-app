import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../models/bitcoin_tracker_model.dart';

abstract class BitcoinTrackerRemoteDataSource {
  Future<BitcoinTrackerModel> getBitcoinInfo();
}

class BitcoinTrackerRemoteDataSourceImpl
    implements BitcoinTrackerRemoteDataSource {
  const BitcoinTrackerRemoteDataSourceImpl({@required this.client});

  final http.Client client;

  @override
  Future<BitcoinTrackerModel> getBitcoinInfo() =>
      _getInfoFromUrl('https://api.coinlore.net/api/ticker/?id=90');

  Future<BitcoinTrackerModel> _getInfoFromUrl(String url) async {
    final http.Response response = await client.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return BitcoinTrackerModel.fromJson(
        json.decode(response.body)[0] as Map<String, dynamic>,
      );
    } else {
      throw ServerException();
    }
  }
}
