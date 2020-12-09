import 'package:bitcoin_tracking_app/features/bitcoin_tracker/presentation/bloc/bloc.dart';
import 'package:bitcoin_tracking_app/features/bitcoin_tracker/presentation/widgets/info_card.dart';
import 'package:bitcoin_tracking_app/features/bitcoin_tracker/presentation/widgets/refresh_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';

class BitcoinTrackerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bitcoin Tracker'),
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<BitcoinTrackerBloc> buildBody(BuildContext context) {
    return BlocProvider<BitcoinTrackerBloc>(
      create: (_) => sl<BitcoinTrackerBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              BlocBuilder<BitcoinTrackerBloc, BitcoinTrackerState>(
                builder: (BuildContext context, BitcoinTrackerState state) {
                  print('$this changed to $state');
                  if (state is Empty) {
                    return const SizedBox();
                  } else if (state is Loading) {
                    return const CircularProgressIndicator();
                  } else if (state is Loaded) {
                    return InfoCard(info: state.bitcoinTracker);
                  } else if (state is Error) {
                    return Text(state.message);
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              const RefreshInfo()
            ],
          ),
        ),
      ),
    );
  }
}
