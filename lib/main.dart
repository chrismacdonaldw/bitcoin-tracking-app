import 'package:flutter/material.dart';
import 'features/bitcoin_tracker/presentation/pages/bitcoin_tracker_page.dart';
import 'injection_container.dart' as di;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bitcoin Tracker',
      theme: ThemeData(
        primaryColor: Colors.amber.shade700,
        accentColor: Colors.amberAccent.shade400,
      ),
      home: BitcoinTrackerPage(),
    );
  }
}
