import 'package:flutter/material.dart';
import 'package:flutter_native/dart_pigeons/battery_pigeon.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final BatteryApi _batteryApi;
  late BatteryInfo _batteryInfo;

  @override
  void initState() {
    super.initState();
    _batteryApi = BatteryApi();
    _batteryInfo = BatteryInfo(level: 0, state: BatteryState.unknown);

    _getBatteryInfo();
  }

  void _getBatteryInfo() async {
    late final BatteryInfo info;

    info = await _batteryApi.getBatteryInfo();

    setState(() {
      _batteryInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Current battery level:',
            ),
            Text(
              '${_batteryInfo.level}',
              style: Theme.of(context).textTheme.headline4,
            ),
            const Text(
              'Current battery state:',
            ),
            Text(
              '${_batteryInfo.state}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getBatteryInfo,
        tooltip: 'Battery info',
        child: const Icon(Icons.battery_unknown),
      ),
    );
  }
}
