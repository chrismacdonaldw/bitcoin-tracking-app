import 'package:bitcoin_tracking_app/features/bitcoin_tracker/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RefreshInfo extends StatefulWidget {
  const RefreshInfo({Key key}) : super(key: key);

  @override
  _RefreshInfoState createState() => _RefreshInfoState();
}

class _RefreshInfoState extends State<RefreshInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialButton(
        child: const Text('Refresh'),
        color: Colors.amber.shade600,
        onPressed: dispatchRefresh,
      ),
    );
  }

  void dispatchRefresh() {
    BlocProvider.of<BitcoinTrackerBloc>(context).add(GetInfoForBitcoin());
  }
}
