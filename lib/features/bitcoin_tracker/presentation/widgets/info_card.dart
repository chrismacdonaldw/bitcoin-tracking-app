import 'package:bitcoin_tracking_app/features/bitcoin_tracker/domain/entities/bitcoin_tracker.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatefulWidget {
  const InfoCard({Key key, @required this.info}) : super(key: key);

  final BitcoinTracker info;

  @override
  _InfoCardState createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Column(
          children: <Widget>[
            Container(
              child: Image.asset('assets/${widget.info.symbol}.png'),
              height: 50,
            ),
            Text('${widget.info.name} - (${widget.info.symbol})'),
            Text('${widget.info.priceUSD}')
          ],
        ),
      ),
    );
  }
}
